import './app.css'

import { supabase } from './supabaseClient'

import logo from "./assets/imba.svg"
import Auth from './pages/auth.imba'
import Account from './pages/account.imba'

global css
	@root
		fs:16px lh:24px fw:400 c:white/87
		color-scheme: light dark
		bgc:#242424
		
tag app

	prop sessionData

	def mount do 
		supabase.auth.onAuthStateChange do(event, session) sessionData = session
		supabase.auth.getSession!.then do({ data: { session } }) sessionData = session
	
	css .logo h:6em p:1.5em

	<self>
		<div>
			if !sessionData
				<Auth />
			else
				<Account session=sessionData />

imba.mount <app>, document.getElementById "app"