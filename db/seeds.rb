
# Create initial admin user
u = User.new(name: 'JD Pagano', admin: true)
u.password= 'orangeranch3'
u.save!


# Create dummy articles
tech = Blog.create(title: 'Tech', subdomain: 'tech')
travel = Blog.create(title: 'Travel', subdomain: 'travel')

5.times do |i|
  Article.create(
    description: "desc of art ##{i}",
    keywords: %w(foo bar baz),
    published: i.odd?,
    body: "This is the body of article ##{i}. This is a really fascinating article",
    title: "Title of art ##{i}",
    blog_id: (i.odd? ? travel.id : tech.id)
    )
end
