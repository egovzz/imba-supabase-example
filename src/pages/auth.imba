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
		console.log 'user: ' + user
		console.log 'session: ' + session
		console.log 'error: ' + error

	def handleLogin
		try 
			loading = true
			const { error } = await supabase.auth.signInWithPassword({ email: email, password: pass})
			if error
				throw error
			# alert('Check your email for the login link!')
		catch error
			# alert(error.error_description || error.message)
			console.log 'error: ', error
		finally 
			loading = false

	def checkSession
		# let mysession = await supabase.auth.getSession!.then do({ data: { session } }) console.log 'data: ', session
		let mysession = await supabase.auth.getSession!
		console.log 'mysession: ', mysession.data.session

	<self>
		<div.container>
			if loading
				<p> 'Loading....'
			else
				<input type='text' placeholder='email...' bind=email>
				<input type='text' placeholder='password...' bind=pass>
				<div>
					<button @click=checkSession> 'Signup'
					<button @click=handleLogin> 'Login'