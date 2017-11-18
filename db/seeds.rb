# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Company.create([name: 'Google',phone:'0912345678', email:'google@gmail.com'])

User.create([email: 'test1@gmail.com',   password: '12345678', password_confirmation: '12345678', name: '測試帳號'])
User.create([email: 'admin@gmail.com',   password: '12345678', password_confirmation: '12345678', name: 'admin測試帳號', role: 1])
User.create([email: 'company@gmail.com', password: '12345678', password_confirmation: '12345678', name: 'company測試帳號', company_id: Company.find_by(name:'google').id])

