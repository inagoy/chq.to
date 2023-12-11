class Visit < ApplicationRecord
  validates_presence_of :ip

  belongs_to :link

  scope :filter_by_ip, ->(ip) { where(ip: ip) }
  scope :filter_by_start_date, ->(start_date) { where('created_at >= ?', start_date) }
  scope :filter_by_end_date, ->(end_date) { where('created_at <= ?', end_date) }

end
