-- audit_log must be append-only — remove write privileges beyond INSERT.
-- Supabase's initialisation scripts grant ALL on public tables to `authenticated`
-- by default; the narrower grant in 0006 only adds, it does not revoke.
revoke update, delete on public.audit_log from authenticated;

-- Introspection helper: returns whether RLS is enabled on a public table.
-- Used by the RLS test suite; also useful for admin tooling.
create or replace function public.table_has_rls(p_table text)
returns boolean
language sql
security definer
stable
as $$
  select rowsecurity
  from pg_tables
  where schemaname = 'public' and tablename = p_table;
$$;

grant execute on function public.table_has_rls(text) to authenticated, service_role;
