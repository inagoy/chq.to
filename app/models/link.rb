class Link < ApplicationRecord

  enum link_type: {
    regular: 'Regular',
    ephemeral: 'Ephemeral',
    private: 'Private',
    temporal: 'Temporal'
  }

  validates_presence_of :url, :slug, :link_type
  validates_presence_of :password, if: -> { link_type == 'private' }
  validates_presence_of :expiration_date, if: -> { link_type == 'temporal' }
  validates_uniqueness_of :url, :slug

  validates :url, format: { with: URI.regexp }
  validates :link_type, inclusion: { in: Link.link_types.keys }


  belongs_to :user
  has_many :visits, dependent: :destroy

  before_create :generate_slug

  private

  def generate_slug
    self.slug = Digest::MD5.hexdigest(self.url)
  end

end
