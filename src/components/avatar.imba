import { supabase } from '../supabaseClient'

export default tag Avatar

	prop size = 150
	prop onUpload
	prop url

	prop avatarUrl
	prop uploading = no

	def downloadImage path
		try
			const { data, error } = await supabase.storage
				.from('avatars')
				.download(path)
			
			if error
				throw error

			const completeUrl = URL.createObjectURL(data)
			avatarUrl = completeUrl
			imba.commit!
		catch error
			console.log error
			window.alert 'Error downloading image'

	def uploadAvatar event
		try
			uploading = yes

			if (!event.target.files || event.target.files.length === 0)
				throw new Error('You must select an image to upload.')

			const file = event.target.files[0]
			const fileExt = file.name.split('.').pop!
			const fileName = `{Math.random!}.{fileExt}`
			const filePath = `{fileName}`

			let { error: uploadError } = await supabase.storage
				.from('avatars')
				.upload(filePath, file)

			if uploadError
				throw uploadError

			onUpload(filePath)
		catch error
			window.alert error.message
		finally
			uploading = no
			imba.commit!

	
	def mount
		if url then downloadImage(url)


	<self>
		<div>
			<img[size:{size}px]
				src=(avatarUrl ?? `https://place-hold.it/{size}x{size}`)
			>
			if uploadin
				<p> 'Uploading'
			else
				<div>
					<label> 'Upload an avatar'
					<div>
						<input
							type="file"
							id="single"
							accept="image/*"
							@change=uploadAvatar
							disabled=uploading
						/>