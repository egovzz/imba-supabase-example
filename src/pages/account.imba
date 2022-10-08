import { supabase } from '../supabaseClient'

export default tag Account

	css .form-widget d:flex fld:column g:20px ta:left p: 50px 0

	prop session
	prop username
	prop website
	prop avatarUrl

	prop loading = no

	def getProfile do
		try
			loading = yes
			const { user } = session

			let { data, error, status } = await supabase
				.from('profiles')
				.select(`username, website, avatar_url`)
				.eq('id', user.id)
				.single!

			if error && status !== 406
				throw error

			if (data) 
				username = data.username
				website = data.website
				avatarUrl = data.avatar_url

		catch error
			alert(error.message)
		finally
			loading = no



	def mount do
		getProfile!


	<self>
		<div>
			if loading
				<p> 'Loading...'
			else
				<div.form-widget>
					<div> "Email: {session.user.email}"
					<div>
						<label htmlFor="username"> 'Name'
						<input id="username" type="text" bind=username />
					<div>
						<label htmlFor="website"> 'Website'
						<input id="website" type="text" bind=website />
						<button disabled=loading> 'Update profile'
		
		<button @click=supabase.auth.signOut!> 'Log out'