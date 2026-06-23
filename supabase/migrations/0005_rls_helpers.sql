create or replace function public.is_member_of(p_org uuid)
returns boolean language sql security definer set search_path = public stable as $$
  select exists (select 1 from public.memberships m
    where m.org_id = p_org and m.user_id = auth.uid());
$$;
create or replace function public.is_admin_of(p_org uuid)
returns boolean language sql security definer set search_path = public stable as $$
  select exists (select 1 from public.memberships m
    where m.org_id = p_org and m.user_id = auth.uid() and m.role in ('owner','admin'));
$$;
grant execute on function public.is_member_of(uuid) to authenticated;
grant execute on function public.is_admin_of(uuid)  to authenticated;
