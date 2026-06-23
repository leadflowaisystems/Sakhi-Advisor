create or replace function public.handle_new_user()
returns trigger language plpgsql security definer set search_path = public as $$
begin
  insert into public.profiles (id, full_name)
  values (new.id, coalesce(new.raw_user_meta_data->>'full_name',''));
  return new;
end; $$;
create trigger on_auth_user_created after insert on auth.users
  for each row execute function public.handle_new_user();

create or replace function public.set_updated_at()
returns trigger language plpgsql as $$
begin new.updated_at = now(); return new; end; $$;
create trigger trg_orgs_updated_at     before update on public.organizations for each row execute function public.set_updated_at();
create trigger trg_profiles_updated_at before update on public.profiles      for each row execute function public.set_updated_at();
create trigger trg_clients_updated_at  before update on public.clients       for each row execute function public.set_updated_at();

create or replace function public.audit_client_insert()
returns trigger language plpgsql security definer set search_path = public as $$
begin
  insert into public.audit_log (org_id, actor_id, action, entity, entity_id, metadata)
  values (new.org_id, auth.uid(), 'create', 'client', new.id::text,
          jsonb_build_object('full_name', new.full_name));
  return new;
end; $$;
create trigger trg_audit_client_insert after insert on public.clients
  for each row execute function public.audit_client_insert();
