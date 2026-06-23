create index idx_memberships_user on public.memberships (user_id);
create index idx_memberships_org  on public.memberships (org_id);
create index idx_clients_org      on public.clients (org_id, created_at desc);
create index idx_audit_org        on public.audit_log (org_id, created_at desc);
