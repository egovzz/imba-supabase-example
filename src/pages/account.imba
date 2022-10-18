import { supabase } from '../supabaseClient'

import Avatar from '../components/avatar.imba'

export default tag Account

	css .form-widget d:flex fld:column g:20px ta:left p: 50px 0 min-width:400px

	prop session
	prop username
	prop website
	prop avatarUrl

	prop loading = no

	def getProfile
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
			window.alert error.message
		finally
			loading = no
			imba.commit! # This will update the screen with the new data

	def updateProfile newAvatarUrl
		try
			loading = yes
			const { user } = session

			const updates = {
				id: user.id,
				username,
				website,
				avatar_url: newAvatarUrl ?? avatarUrl,
				updated_at: new Date(),
			}

			let { error } = await supabase.from('profiles').upsert(updates)

			if error
				throw error

			avatarUrl = newAvatarUrl

			imba.commit!
		catch error
			window.alert error.message
		finally
			loading = no

	def setup
		getProfile!

	<self>
		<div>
			if loading
				<p> 'Loading...'
			else
				<Avatar 
					url=avatarUrl
					onUpload=(do(url) updateProfile(url))
				/>
				<div.form-widget>
					<div> "Email: {session.user.email}"
					<div>
						<label htmlFor="username"> 'Username'
						<input id="username" type="text" bind=username />
					<div>
						<label htmlFor="website"> 'Website'
						<input id="website" type="text" bind=website />	
					<div>
						<button.active disabled=loading @click=updateProfile!> 'Update profile'
		
		<button @click=supabase.auth.signOut!> 'Log out'