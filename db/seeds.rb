# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(
        email: 'test@test.com',
        password: 'testtest',
        name: 'Test User',
        roles: 'site_admin'
)

puts '1 Admin user created.'

2.times do |topic|
  Topic.create!(
      title: "Topic ##{topic}"
  )
end

puts "2 topics created."

15.times do |blog|
  Blog.create!(
      title: "Blog Post No.#{blog}",
      body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."\
            "Rhoncus est pellentesque elit ullamcorper. Sed adipiscing diam donec adipiscing tristique risus nec. Habitant morbi tristique senectus et netus."\
            "Est sit amet facilisis magna etiam tempor orci eu. Sociis natoque penatibus et magnis dis parturient."\
            "Adipiscing vitae proin sagittis nisl rhoncus mattis rhoncus. Ac tortor dignissim convallis aenean et tortor. Massa eget egestas purus viverra accumsan."\
            "Nunc eget lorem dolor sed viverra ipsum nunc. Quisque non tellus orci ac auctor augue. Tortor posuere ac ut consequat semper viverra nam libero."\
            "Vitae semper quis lectus nulla at volutpat. Ut pharetra sit amet aliquam id diam.",
      topic_id: Topic.last.id
  )
end

puts "15 Blogs created."

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

# 1.times do |user|
#   User.first.update!(roles: "site_admin")
# end
