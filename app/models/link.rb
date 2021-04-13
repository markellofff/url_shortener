# Model class for link
class Link < ApplicationRecord
  validates_presence_of :url
  validates :url, format: URI.regexp(%w[http https])
  validates_uniqueness_of :slug
  validates_length_of :url, within: 3..255, on: :create, message: 'too long'
  validates_length_of :slug, within: 3..255, on: :create, message: 'too long'
  before_validation :generate_slug

  def short
    Rails.application.routes.url_helpers.short_url(slug: slug)
  end

  private

  def generate_slug
    self.slug = SecureRandom.uuid[0..5] unless slug.present?
    true
  end
end