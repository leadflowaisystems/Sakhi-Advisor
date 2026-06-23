import { redirect } from 'next/navigation'
import { createClient } from '@/lib/supabase/server'
import AddClientForm from './AddClientForm'

export default async function ClientsPage() {
  const supabase = await createClient()

  const {
    data: { user },
  } = await supabase.auth.getUser()
  if (!user) redirect('/login')

  // Resolve org_id server-side from membership — never trust it from the browser
  const { data: membership } = await supabase
    .from('memberships')
    .select('org_id')
    .eq('user_id', user.id)
    .limit(1)
    .single()

  if (!membership) redirect('/onboarding')

  const { data: clients } = await supabase
    .from('clients')
    .select('id, full_name, phone, email, created_at')
    .eq('org_id', membership.org_id)
    .order('created_at', { ascending: false })

  return (
    <div className="max-w-2xl mx-auto p-6">
      <h1 className="text-2xl font-bold text-gray-900 mb-6">Clients</h1>

      <AddClientForm orgId={membership.org_id} />

      <div className="mt-8 space-y-3">
        {clients && clients.length > 0 ? (
          clients.map((client) => (
            <div
              key={client.id}
              className="bg-white p-4 rounded-xl border border-gray-100 shadow-sm"
            >
              <p className="font-medium text-gray-900">{client.full_name}</p>
              {client.phone && (
                <p className="text-sm text-gray-500">{client.phone}</p>
              )}
              {client.email && (
                <p className="text-sm text-gray-500">{client.email}</p>
              )}
            </div>
          ))
        ) : (
          <p className="text-gray-400 text-sm">
            No clients yet. Add your first one above.
          </p>
        )}
      </div>
    </div>
  )
}
