import { describe, it, expect, beforeAll, afterAll } from 'vitest'
import {
  anonClient,
  createTestUser,
  signIn,
  cleanupTestUsers,
  adminClient,
  type TestUser,
} from './helpers/supabase.js'
import type { Database } from '@sakhi/db'

type OrgRow = Database['public']['Tables']['organizations']['Row']

let userA: TestUser
let userB: TestUser
let orgA: OrgRow
let orgB: OrgRow
let clientAId: string

beforeAll(async () => {
  userA = await createTestUser()
  userB = await createTestUser()

  await signIn(userA)
  await signIn(userB)

  const { data: a, error: errA } = await userA.client.rpc('create_organization', {
    p_name: 'Org Alpha',
  })
  if (errA || !a) throw new Error(`create_organization A: ${errA?.message}`)
  orgA = a as OrgRow

  const { data: b, error: errB } = await userB.client.rpc('create_organization', {
    p_name: 'Org Beta',
  })
  if (errB || !b) throw new Error(`create_organization B: ${errB?.message}`)
  orgB = b as OrgRow
})

afterAll(async () => {
  await cleanupTestUsers([userA.id, userB.id])
})

// ── 1. Setup ──────────────────────────────────────────────────────────────────
describe('1 · setup — both users have orgs', () => {
  it('org A was created', () => {
    expect(orgA.id).toBeTruthy()
    expect(orgA.name).toBe('Org Alpha')
  })
  it('org B was created', () => {
    expect(orgB.id).toBeTruthy()
    expect(orgB.name).toBe('Org Beta')
  })
})

// ── 2. Insert ─────────────────────────────────────────────────────────────────
describe('2 · A inserts a client into org A', () => {
  it('insert succeeds and returns the row', async () => {
    const { data, error } = await userA.client
      .from('clients')
      .insert({ org_id: orgA.id, full_name: 'Meena Sharma' })
      .select()
      .single()

    expect(error).toBeNull()
    expect(data).toBeTruthy()
    clientAId = data!.id
  })
})

// ── 3. A reads own clients ────────────────────────────────────────────────────
describe('3 · A can read their own clients', () => {
  it('returns exactly one row with the correct name', async () => {
    const { data, error } = await userA.client
      .from('clients')
      .select()
      .eq('org_id', orgA.id)

    expect(error).toBeNull()
    expect(data).toHaveLength(1)
    expect(data![0]!.full_name).toBe('Meena Sharma')
  })
})

// ── 4. B cannot read A's clients ─────────────────────────────────────────────
describe("4 · B cannot read A's clients", () => {
  it('RLS filters the row — returns zero rows, no error', async () => {
    const { data, error } = await userB.client
      .from('clients')
      .select()
      .eq('org_id', orgA.id)

    expect(error).toBeNull()
    expect(data).toHaveLength(0)
  })
})

// ── 5. B cannot update A's clients ───────────────────────────────────────────
describe("5 · B cannot update A's clients", () => {
  it('update matches 0 rows; A\'s row is unchanged', async () => {
    const { data, error } = await userB.client
      .from('clients')
      .update({ full_name: 'HACKED' })
      .eq('id', clientAId)
      .select()

    expect(error).toBeNull()
    expect(data).toHaveLength(0)

    const { data: check } = await userA.client
      .from('clients')
      .select('full_name')
      .eq('id', clientAId)
      .single()
    expect(check?.full_name).toBe('Meena Sharma')
  })
})

// ── 6. B cannot delete A's clients ───────────────────────────────────────────
describe("6 · B cannot delete A's clients", () => {
  it('delete matches 0 rows; row still exists for A', async () => {
    const { data, error } = await userB.client
      .from('clients')
      .delete()
      .eq('id', clientAId)
      .select()

    expect(error).toBeNull()
    expect(data).toHaveLength(0)

    const { data: check } = await userA.client
      .from('clients')
      .select()
      .eq('id', clientAId)
    expect(check).toHaveLength(1)
  })
})

// ── 7. B cannot insert into A's org ──────────────────────────────────────────
describe("7 · B cannot insert a client into A's org_id", () => {
  it('insert is rejected by the RLS with-check', async () => {
    const { data, error } = await userB.client
      .from('clients')
      .insert({ org_id: orgA.id, full_name: 'Infiltrator' })
      .select()

    // Supabase returns a 42501 permission error or empty data — either proves rejection
    const rejected = error !== null || (data !== null && data.length === 0)
    expect(rejected).toBe(true)

    // Confirm no rogue row was created
    const { data: check } = await userA.client
      .from('clients')
      .select()
      .eq('org_id', orgA.id)
      .eq('full_name', 'Infiltrator')
    expect(check).toHaveLength(0)
  })
})

// ── 8. Anon cannot read clients ───────────────────────────────────────────────
describe('8 · anonymous user cannot read clients', () => {
  it('returns zero rows (no session = no matching RLS policy)', async () => {
    const anon = anonClient()
    const { data, error } = await anon.from('clients').select()
    const denied = error !== null || (data !== null && data.length === 0)
    expect(denied).toBe(true)
  })
})

// ── 9. RPC → caller has exactly one owner membership ─────────────────────────
describe('9 · create_organization gives caller exactly one owner membership', () => {
  it('A has one owner membership for org A', async () => {
    const { data, error } = await userA.client
      .from('memberships')
      .select()
      .eq('org_id', orgA.id)
      .eq('user_id', userA.id)

    expect(error).toBeNull()
    expect(data).toHaveLength(1)
    expect(data![0]!.role).toBe('owner')
  })

  it('B has one owner membership for org B', async () => {
    const { data, error } = await userB.client
      .from('memberships')
      .select()
      .eq('org_id', orgB.id)
      .eq('user_id', userB.id)

    expect(error).toBeNull()
    expect(data).toHaveLength(1)
    expect(data![0]!.role).toBe('owner')
  })
})

// ── 10. Audit log ─────────────────────────────────────────────────────────────
describe('10 · audit log', () => {
  it('client insert created an audit row visible to A', async () => {
    const { data, error } = await userA.client
      .from('audit_log')
      .select()
      .eq('org_id', orgA.id)
      .eq('action', 'create')
      .eq('entity', 'client')

    expect(error).toBeNull()
    expect(data!.length).toBeGreaterThan(0)
  })

  it("B cannot read A's audit rows", async () => {
    const { data, error } = await userB.client
      .from('audit_log')
      .select()
      .eq('org_id', orgA.id)

    expect(error).toBeNull()
    expect(data).toHaveLength(0)
  })

  it('nobody can update audit rows — no update policy exists', async () => {
    const { data: rows } = await userA.client
      .from('audit_log')
      .select('id')
      .eq('org_id', orgA.id)
      .limit(1)

    if (!rows || rows.length === 0) return

    // @ts-expect-error — update on audit_log intentionally has no RLS policy
    const { error } = await userA.client
      .from('audit_log')
      .update({ action: 'tampered' })
      .eq('id', rows[0]!.id)

    expect(error).not.toBeNull()
  })

  it('nobody can delete audit rows — no delete policy exists', async () => {
    const { data: rows } = await userA.client
      .from('audit_log')
      .select('id')
      .eq('org_id', orgA.id)
      .limit(1)

    if (!rows || rows.length === 0) return

    const { error } = await userA.client
      .from('audit_log')
      .delete()
      .eq('id', rows[0]!.id)

    expect(error).not.toBeNull()
  })
})

// ── 11. Profile isolation ─────────────────────────────────────────────────────
describe('11 · profile isolation', () => {
  it("A cannot read B's profile", async () => {
    const { data, error } = await userA.client
      .from('profiles')
      .select()
      .eq('id', userB.id)

    expect(error).toBeNull()
    expect(data).toHaveLength(0)
  })

  it('A can read their own profile', async () => {
    const { data, error } = await userA.client
      .from('profiles')
      .select()
      .eq('id', userA.id)

    expect(error).toBeNull()
    expect(data).toHaveLength(1)
  })
})

// ── 12. RLS enabled on all five tenant tables ─────────────────────────────────
describe('12 · rowsecurity = true on all tenant tables', () => {
  const tables = [
    'organizations',
    'profiles',
    'memberships',
    'clients',
    'audit_log',
  ] as const

  it.each(tables)('%s has RLS enabled', async (table) => {
    const { data, error } = await adminClient
      .rpc('table_has_rls', { p_table: table })

    expect(error).toBeNull()
    expect(data).toBe(true)
  })
})
