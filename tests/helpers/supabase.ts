import { createClient } from '@supabase/supabase-js'
import type { Database } from '@sakhi/db'

// SUPABASE_URL / SUPABASE_ANON_KEY are the canonical test names (set in CI).
// NEXT_PUBLIC_* are the Next.js build names — same values, used as local fallback
// so developers only need one .env file at the monorepo root.
const SUPABASE_URL =
  process.env['SUPABASE_URL'] ??
  process.env['NEXT_PUBLIC_SUPABASE_URL'] ??
  'http://127.0.0.1:54321'
const ANON_KEY =
  process.env['SUPABASE_ANON_KEY'] ??
  process.env['NEXT_PUBLIC_SUPABASE_ANON_KEY'] ??
  ''
const SERVICE_ROLE_KEY = process.env['SUPABASE_SERVICE_ROLE_KEY'] ?? ''

if (!ANON_KEY) throw new Error('SUPABASE_ANON_KEY env var is required')
if (!SERVICE_ROLE_KEY) throw new Error('SUPABASE_SERVICE_ROLE_KEY env var is required')

// Admin client for test setup/teardown ONLY — never used in production browser code.
export const adminClient = createClient<Database>(SUPABASE_URL, SERVICE_ROLE_KEY, {
  auth: { autoRefreshToken: false, persistSession: false },
})

export function anonClient() {
  return createClient<Database>(SUPABASE_URL, ANON_KEY, {
    auth: { autoRefreshToken: false, persistSession: false },
  })
}

export interface TestUser {
  id: string
  email: string
  password: string
  client: ReturnType<typeof anonClient>
}

let counter = 0

export async function createTestUser(): Promise<TestUser> {
  const n = ++counter
  const email = `test-${n}-${Date.now()}@sakhi-test.local`
  const password = 'Test1234!'
  const fullName = `Test User ${n}`

  // Sign up via the real auth path — no admin shortcut, proves the real flow works.
  const client = anonClient()
  const { data, error } = await client.auth.signUp({
    email,
    password,
    options: { data: { full_name: fullName } },
  })
  if (error) throw new Error(`signUp failed: ${error.message}`)
  if (!data.user) throw new Error('signUp returned no user')

  return { id: data.user.id, email, password, client }
}

export async function signIn(user: TestUser): Promise<void> {
  const { error } = await user.client.auth.signInWithPassword({
    email: user.email,
    password: user.password,
  })
  if (error) throw new Error(`signIn failed: ${error.message}`)
}

export async function cleanupTestUsers(userIds: string[]): Promise<void> {
  for (const id of userIds) {
    await adminClient.auth.admin.deleteUser(id)
  }
}
