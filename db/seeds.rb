User.create!(first_name:            "Matt",
             last_name:             "Velez",
             email:                 "matt@mattvelez.net",
             password:              ENV["matt_password"],
             password_confirmation: ENV["matt_password"])

99.times do |n|
  first_name = Faker::Name.first_name
  last_name  = Faker::Name.last_name
  email      = Faker::Internet.safe_email(first_name + n)
  password   = "password"
  User.create!(first_name:            first_name,
               last_name:             last_name,
               email:                 email,
               password:              password,
               password_confirmation: password)
end

matt = User.first
User.second.friend(matt)
User.last.friend(matt)

users = User.order(:created_at).take(6)
50.times do
  text = Faker::Lorem.paragraph
  users.each { |user| user.posts.create!(text: text) }
end