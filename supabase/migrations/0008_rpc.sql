create or replace function public.create_organization(p_name text)
returns public.organizations language plpgsql security definer set search_path = public as $$
declare v_org public.organizations;
begin
  if auth.uid() is null then raise exception 'not authenticated'; end if;
  if p_name is null or char_length(trim(p_name)) = 0 then raise exception 'organization name required'; end if;
  insert into public.organizations (name, created_by) values (trim(p_name), auth.uid()) returning * into v_org;
  insert into public.memberships (org_id, user_id, role) values (v_org.id, auth.uid(), 'owner');
  insert into public.audit_log (org_id, actor_id, action, entity, entity_id)
    values (v_org.id, auth.uid(), 'create', 'organization', v_org.id::text);
  return v_org;
end; $$;
grant execute on function public.create_organization(text) to authenticated;
