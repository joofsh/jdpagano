class Blog
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :subdomain, type: String


  has_many :articles

end
