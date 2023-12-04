class Visit < ApplicationRecord
  validates_presence_of :ip, :date
  validates_uniqueness_of :ip, scope: :date

  belongs_to :link

end
