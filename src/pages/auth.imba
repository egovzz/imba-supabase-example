import { supabase } from '../supabaseClient'

export default tag Auth

	prop email
	prop pass
	prop loading = false

	css .container d:flex fld:column

	def handleSignup
		const { user, session, error } = await supabase.auth.signUp({
			email: email,
			password: pass,
		})

	def handleLogin
		try 
			loading = true
			const { error } = await supabase.auth.signInWithPassword({ email: email, password: pass})
			if error
				throw error
			# alert('Check your email for the login link!')
		catch error
			window.alert(error.error_description || error.message)
		finally 
			loading = false

	<self>
		<div.container>
			<h1> 'Imba + Supabase'
			if loading
				<p> 'Loading....'
			else
				<input type='text' placeholder='email...' bind=email>
				<input type='text' placeholder='password...' bind=pass>
				<div>
					<button @click=handleSignup> 'Signup'
					<button @click=handleLogin> 'Login'