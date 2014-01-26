class Post < ActiveRecord::Base
  attr_accessible :title, :content, :is_published

  scope :recent, order: "created_at DESC", limit: 5

  before_save :titleize_title, :generate_slug

  validates_presence_of :title, :content


  private

  def titleize_title
    self.title = self.title.titleize
  end

  def generate_slug
    self.slug = self.title.downcase.gsub(" ", "-").gsub(/(!|\.|\?)/, "")
  end
end