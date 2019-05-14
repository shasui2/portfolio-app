# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
2.times do |topic|
  Topic.create!(
      title: "Topic ##{topic}"
  )
end

puts "2 topics created."

5.times do |blog|
  Blog.create!(
      title: "Blog Post No.#{blog}",
      body: "This is a blog post.",
      topic_id: Topic.last.id
  )
end

puts "5 Blogs created."

5.times do |skill|
  Skill.create!(
      title: "Rails #{skill}",
      percent_utilised: 15
  )
end

puts "5 Skills created."

8.times do |portfolio|
  Portfolio.create!(
      title: "Portfolio #{portfolio}",
      subtitle: "Ruby on Rails",
      body: "Some random body",
      main_image: "https://via.placeholder.com/600x400",
      thumb_image: "https://via.placeholder.com/350x200"
  )
end

1.times do |portfolio|
  Portfolio.create!(
      title: "Portfolio #{portfolio}",
      subtitle: "Angular",
      body: "Some random body",
      main_image: "https://via.placeholder.com/600x400",
      thumb_image: "https://via.placeholder.com/350x200"
  )
end

puts "9 Portfolios created."

3.times do |technology|
  Portfolio.last.technologies.create!(
      name: "Technology #{technology}",
      portfolio_id: Portfolio.last.id
  )
end

puts "3 Technologies created."

1.times do | user |
  User.first.update!(roles: "site_admin")
end
