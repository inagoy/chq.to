class Link < ApplicationRecord


  validates_presence_of :url, :type
  validates_uniqueness_of :url
  validates :url, format: { with: URI.regexp }

  belongs_to :user
  has_many :visits, dependent: :destroy

  before_create :generate_slug

  def time_ago
    seconds_ago = Time.zone.now - created_at
    minutes_ago = (seconds_ago / 60).to_i
    hours_ago = (minutes_ago / 60).to_i
    days_ago = (hours_ago / 24).to_i

    case
      when minutes_ago < 1 then "Hace instantes"
      when hours_ago < 1 then "Hace #{minutes_ago} minutos"
      when days_ago < 1 then "Hace #{hours_ago} horas"
      else "Hace #{days_ago} días"
    end
  end

  private

  def generate_slug
    self.slug = Digest::MD5.hexdigest(url)
  end
end
