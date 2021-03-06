class Article
  include Paperclip::Glue
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :body, type: String, default: ''
  field :hero_image_file_name, type: String
  field :slug, type: String
  field :description, type: String
  field :keywords, type: Array, default: [nil,nil,nil]
  field :published, type: Mongoid::Boolean, default: false
  field :first_published_at, type: DateTime

  belongs_to :blog

  index({ slug: 1 }, { unique: true, name: "slug_index" })

  before_save :generate_slug


  has_attached_file :hero_image, styles: { main: "1170x400!", thumbnail: "100x75" },
    path: ":rails_root/public/system/:class/:attachment/:id/:style/:filename",
    url: "/system/:class/:attachment/:id/:style/:filename"


  def body_preview
    index = body.index("```") # finds the first block of code
    body[0...index]
  end

  def printable_post_date
    created_at.strftime("%m/%d/%y")
  end

  def printable_keywords
    keywords.reject(&:blank?).map(&:capitalize)
  end

private
  def generate_slug
    unless slug && !title
      self.slug = title.parameterize
    end
  end
end
