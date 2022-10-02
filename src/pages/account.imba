import { supabase } from '../supabaseClient'

export default tag Account
	<self>
		<p> 'This is account page'
		<button @click=supabase.auth.signOut!> 'Log out'