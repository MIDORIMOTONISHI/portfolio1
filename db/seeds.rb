# coding: utf-8

User.create!(name: "管理者",
             email: "admin@email.com",
             password: "password",
             password_confirmation: "password",
             admin: true)
             
User.create!(name: "松本 翠",
             email: "sample1@email.com",
             password: "password",
             password_confirmation: "password",
             position: "デザイナー")
             
User.create!(name: "松浦 直晶",
             email: "sample2@email.com",
             password: "password",
             password_confirmation: "password",
             position: "デザイナー")

User.create!(name: "青砥 晴子",
             email: "sample3@email.com",
             password: "password",
             password_confirmation: "password",
             position: "デザイナー")

20.times do |n|
  name  = Faker::Name.name
  email = "sample-#{n+1}@email.com"
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               position: "カスタマー")
end