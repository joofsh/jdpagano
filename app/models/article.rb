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
  field :published, type: Boolean, default: false

  index({ slug: 1 }, { unique: true, name: "slug_index" })

  before_save :generate_slug


  has_attached_file :hero_image, styles: { main: "770x300!", thumbnail: "100x75" }


  def body_preview
    index = body.index("```") # finds the first block of code
    body[0...index]
  end

  def printable_post_date
    created_at.strftime("%m/%d/%y")
  end

  def printable_keywords
    keywords.reject(&:blank?).map(&:capitalize).join(', ')
  end
private
  def generate_slug
    unless slug && !title
      self.slug = title.downcase.gsub(/[^0-9a-z ]/i, '').gsub(' ','-')
    end
  end
end
