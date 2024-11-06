module Organization::Sluggable
  extend ActiveSupport::Concern

  included do
    before_save :generate_slug, if: -> { slug.blank? }
  end

  def generate_slug
    self.slug = name.parameterize || slug.parameterize
  end
end
