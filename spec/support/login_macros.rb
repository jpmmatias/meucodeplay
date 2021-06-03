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

	def student_login(
		student = Student.create!(
			email: 'joãoestudante@gmail.com',
			name: 'João Estudante',
			password: 'Senh@1234',
		)
	)
		login_as student, scope: :student
		student
	end
end
