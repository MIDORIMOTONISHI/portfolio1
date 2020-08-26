# coding: utf-8

User.create!(name: "管理者",
             email: "admin@email.com",
             password: "password",
             password_confirmation: "password",
             position: "管理者",
             admin: true)
             
User.create!(name: "森本 緑",
             email: "designer1@email.com",
             password: "password",
             password_confirmation: "password",
             position: "デザイナー",
             img: open("./public/user_images/midori.jpg"))
             
User.create!(name: "松村 直晶",
             email: "designer2@email.com",
             password: "password",
             password_confirmation: "password",
             position: "デザイナー",
             img: open("./public/user_images/naoaki.jpg"))

User.create!(name: "青木 晴子",
             email: "designer3@email.com",
             password: "password",
             password_confirmation: "password",
             position: "デザイナー",
             img: open("./public/user_images/haruko.jpg"))

5.times do |n|
  name  = Faker::Name.name
  email = "customer#{n+1}@email.com"
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               position: "カスタマー")
end
               
Design.create!(title: "春ジャグラー",
             type: "季節-春",
             machine: "ジャグラー",
             user_id: "2",
             image: open("./public/user_images/haru01.jpg"))
             
Design.create!(title: "春、それがいい",
             type: "季節-春",
             machine: "花の慶次",
             user_id: "2",
             image: open("./public/user_images/haru02.jpg"))
             
Design.create!(title: "桜開花",
             type: "季節-春",
             machine: "",
             user_id: "3",
             image: open("./public/user_images/haru03.jpg"))
             
Design.create!(title: "北斗　北斗七星",
             type: "機種訴求",
             machine: "北斗の拳",
             user_id: "2",
             image: open("./public/user_images/hokuto01.jpg"))

Design.create!(title: "北斗　覇王",
             type: "機種訴求",
             machine: "北斗の拳",
             user_id: "2",
             image: open("./public/user_images/hokuto02.jpg"))
             
Design.create!(title: "北斗　ラオウとケンシロウ",
             type: "機種訴求",
             machine: "北斗の拳",
             user_id: "2",
             image: open("./public/user_images/hokuto03.jpg"))
             
Design.create!(title: "UNOで初打ち　ジャグラー",
             type: "季節-冬",
             machine: "ジャグラー",
             user_id: "3",
             image: open("./public/user_images/huyu01.jpg"))
             
Design.create!(title: "UNOで初打ち　北斗",
             type: "季節-冬",
             machine: "北斗",
             user_id: "3",
             image: open("./public/user_images/huyu02.jpg"))
             
Design.create!(title: "ジャグラー増台",
             type: "機種訴求",
             machine: "ジャグラー",
             user_id: "4",
             image: open("./public/user_images/jug01.jpg"))
             
Design.create!(title: "ジャグラー祭！",
             type: "機種訴求",
             machine: "ジャグラー",
             user_id: "4",
             image: open("./public/user_images/jug02.jpg"))
             
Design.create!(title: "新台　花の慶次",
             type: "機種訴求",
             machine: "花の慶次",
             user_id: "2",
             image: open("./public/user_images/keiji01.jpg"))
             
Design.create!(title: "新台　花の慶次02",
             type: "機種訴求",
             machine: "花の慶次",
             user_id: "2",
             image: open("./public/user_images/keiji02.jpg"))

Design.create!(title: "UNOの夏　海物語",
             type: "季節-夏",
             machine: "海物語",
             user_id: "3",
             image: open("./public/user_images/natu01.jpg"))
             
Design.create!(title: "七夕",
             type: "季節-夏",
             machine: "",
             user_id: "3",
             image: open("./public/user_images/natu02.jpg"))
             
Design.create!(title: "UNO SUMMER 海物語",
             type: "季節-夏",
             machine: "海物語",
             user_id: "2",
             image: open("./public/user_images/natu03.jpg"))
             
Design.create!(title: "シンフォギア01",
             type: "機種訴求",
             machine: "その他未分類",
             user_id: "4",
             image: open("./public/user_images/sin01.png"))
             
Design.create!(title: "シンフォギア02",
             type: "機種訴求",
             machine: "その他未分類",
             user_id: "4",
             image: open("./public/user_images/sin02.png"))
             
Design.create!(title: "ハロウィンマリン",
             type: "季節-秋",
             machine: "海物語",
             user_id: "2",
             image: open("./public/user_images/aki01.jpg"))

Design.create!(title: "ハロウィンクジラッキー",
             type: "季節-秋",
             machine: "海物語",
             user_id: "3",
             image: open("./public/user_images/aki02.jpg"))