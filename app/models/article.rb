class Article
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip

  field :title, type: String
  field :body, type: String, default: ''

  has_mongoid_attached_file :hero_image, styles: { main: "770x300!", thumbnail: "100x75" }


  def printable_post_date
    created_at.strftime("%m/%d/%y")
  end
end
