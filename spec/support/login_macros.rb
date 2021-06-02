module LoginMacros
	def user_login(
		user = User.create!(
			email: 'joão@gmail.com',
			name: 'João',
			password: 'Senh@1234',
		)
	)
		login_as user, scope: :user
		user
	end
end
