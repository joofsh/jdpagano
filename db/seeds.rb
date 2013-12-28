
# Create initial admin user
u = User.new(name: 'JD Pagano', email: 'jonathanpagano@gmail.com', admin: true)
u.password= 'orangeranch3'
u.save!


# Create 2 blogs
tech = Blog.create(title: 'Tech', subdomain: 'tech')
travel = Blog.create(title: 'Travel', subdomain: 'travel')

# Create dummy articles
7.times do |i|
  Article.create(
    description: "desc of art ##{i}",
    keywords: %w(foo bar baz),
    published: i < 4,
    body: "This is the body of article ##{i}. This is a really fascinating article",
    title: "Title of art ##{i}",
    blog_id: (i.odd? ? travel.id : tech.id)
    )
end
