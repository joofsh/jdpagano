class Article
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :body, type: String, default: ''
  field :image, type: String


  def printable_post_date
    created_at.strftime("%m/%d/%y")
  end
end
