matt = User.create!(first_name:            "Matt",
                    last_name:             "Velez",
                    email:                 "matt@mattvelez.net",
                    password:              ENV["matt_password"],
                    password_confirmation: ENV["matt_password"])
matt.confirm!

99.times do |n|
  first_name = Faker::Name.first_name
  last_name  = Faker::Name.last_name
  email      = Faker::Internet.safe_email("#{first_name}-#{n+1}")
  password   = "password"
  user = User.create!(first_name:            first_name,
                      last_name:             last_name,
                      email:                 email,
                      password:              password,
                      password_confirmation: password)
  user.confirm!
end

User.second.friend(matt)
matt.accept_friendship(User.second)
User.last.friend(matt)
matt.accept_friendship(User.last)
User.third.friend(matt)

users = User.order(:created_at).take(6)
50.times do
  text    = Faker::Lorem.paragraph(4)
  comment = Faker::Lorem.paragraph(2)
  users.each do |user|
    post = user.posts.create!(text: text)
    post.comments.create!(text: comment, user_id: user.id)
    post.likes.create!(user_id: user.id)
  end
end