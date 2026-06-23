alter table public.organizations enable row level security;
alter table public.profiles      enable row level security;
alter table public.memberships   enable row level security;
alter table public.clients       enable row level security;
alter table public.audit_log     enable row level security;

create policy profiles_select_own on public.profiles for select using (id = auth.uid());
create policy profiles_update_own on public.profiles for update using (id = auth.uid()) with check (id = auth.uid());

create policy org_select_member on public.organizations for select using (public.is_member_of(id));
create policy org_update_admin  on public.organizations for update using (public.is_admin_of(id)) with check (public.is_admin_of(id));

create policy mem_select_self_or_admin on public.memberships for select using (user_id = auth.uid() or public.is_admin_of(org_id));
create policy mem_admin_insert on public.memberships for insert with check (public.is_admin_of(org_id));
create policy mem_admin_update on public.memberships for update using (public.is_admin_of(org_id)) with check (public.is_admin_of(org_id));
create policy mem_admin_delete on public.memberships for delete using (public.is_admin_of(org_id));

create policy clients_select on public.clients for select using (public.is_member_of(org_id));
create policy clients_insert on public.clients for insert with check (public.is_member_of(org_id));
create policy clients_update on public.clients for update using (public.is_member_of(org_id)) with check (public.is_member_of(org_id));
create policy clients_delete on public.clients for delete using (public.is_member_of(org_id));

create policy audit_select on public.audit_log for select using (public.is_member_of(org_id));
create policy audit_insert on public.audit_log for insert with check (public.is_member_of(org_id) and actor_id = auth.uid());

grant select, insert, update, delete on public.organizations to authenticated;
grant select, insert, update, delete on public.profiles      to authenticated;
grant select, insert, update, delete on public.memberships   to authenticated;
grant select, insert, update, delete on public.clients       to authenticated;
grant select, insert                 on public.audit_log     to authenticated;
