require 'faker'

topics = []
55.times do
  topics << Topic.create(
    name: Faker::Lorem.words(rand(1..10)).join(" "),
    description: Faker::Lorem.paragraph(rand(1..4))
    )
    
end

rand(5..10).times do
  password = Faker::Lorem.characters(10)
  u = User.new(
    name: Faker::Name.name, 
    email: Faker::Internet.email, 
    password: password, 
    password_confirmation: password)
  u.skip_confirmation!
  u.save



  rand(5..12).times do
      topic = topics.first
      p = u.posts.create(
      topic: topic,
      title: Faker::Lorem.words(rand(1..10)).join(" "),
      body: Faker::Lorem.paragraphs(rand(1..4)).join("\n"))
    
      u.update_attribute(:created_at, Time.now - rand(600..31536000))

      topics.rotate!
    end

    post_count = Post.count
    User.all.each do |user|
      rand(30..50).times do
        p = Post.find(rand(1..post_count))
        c = user.comments.create(
          body: Faker::Lorem.paragraphs(rand(1..2)).join("\n"),
          post: p)
        c.update_attribute(:created_at, Time.now - rand(600..31536000))
      end
    end
end
  


u = User.new(
  name: 'Admin User',
  email: 'admin@example.com', 
  password: 'helloworld', 
  password_confirmation: 'helloworld')
u.skip_confirmation!
u.save
u.update_attribute(:role, 'admin')

u = User.new(
  name: 'Moderator User',
  email: 'moderator@example.com', 
  password: 'helloworld', 
  password_confirmation: 'helloworld')
u.skip_confirmation!
u.save
u.update_attribute(:role, 'moderator')

u = User.new(
  name: 'Member User',
  email: 'member@example.com', 
  password: 'helloworld', 
  password_confirmation: 'helloworld')
u.skip_confirmation!
u.save



puts "Seed finished"
puts "#{User.count} users created"
puts "#{Post.count} posts created"
puts "#{Topic.count} topics created"
puts "#{Comment.count} comments created"



