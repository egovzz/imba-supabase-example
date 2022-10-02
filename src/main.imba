import './app.css'

import { supabase } from './supabaseClient'

import Counter from './components/counter.imba'
import logo from "./assets/imba.svg"
import Auth from './pages/auth.imba'
import Account from './pages/account.imba'

global css
	@root
		fs:16px lh:24px fw:400 c:white/87
		color-scheme: light dark
		bgc:#242424
		
tag app

	prop session

	def mount do 
		supabase.auth.getSession!.then do({ data: { session } }) session = session
		supabase.auth.onAuthStateChange do(_event, session) session = session
		
	
	css .logo h:6em p:1.5em

	<self>
		<div>
			if !session
				<Auth />
			else
				<Account />
			
		# 	<a href="https://imba.io" target="_blank">
		# 		# use svg as an svg tag
		# 		<svg.logo[h:6.5em] src=logo>

		# 	<a href="https://vitejs.dev" target="_blank">
		# 		<img.logo[filter@hover:drop-shadow(0 0 4em #646cffaa)] src="/vite.svg" alt="Vite Logo">

		# 	<a href="https://imba.io" target="_blank">
		# 		# use svg as an image
		# 		<img.logo[filter@hover:drop-shadow(0 0 4em #ff3e00aa) h:6.5em transform:rotateY(180deg)] src="./assets/imba.svg" alt="Imba Logo">

		# <h1[c:yellow4]> "Vite + Imba"
		# <div.card> 
		# 	<Counter>
		# <p> "Check out"
		# 	<a href="https://imba.io" target="_blank"> " Imba.io"
		# 	", the Imba documentation website"
		# <p[c:#888]> "Click on the Vite and Imba logos to learn more!!!"


imba.mount <app>, document.getElementById "app"