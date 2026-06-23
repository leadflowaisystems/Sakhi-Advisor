import { createBrowserClient } from '@supabase/ssr'
import type { Database } from '@sakhi/db'

// Browser client — anon key only. Service role is NEVER accessible in browser code.
export function createClient() {
  return createBrowserClient<Database>(
    process.env['NEXT_PUBLIC_SUPABASE_URL']!,
    process.env['NEXT_PUBLIC_SUPABASE_ANON_KEY']!,
  )
}
