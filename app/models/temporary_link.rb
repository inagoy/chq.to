class TemporaryLink < Link
  validates_presence_of :expiration_date
  validate :expiration_date_in_future, if: -> { expiration_date.present? }

  def accessible?
    Time.now < self.expiration_date
  end

  private

  def expiration_date_in_future
    if self.expiration_date.nil? || self.expiration_date <= Time.now
      errors.add(:expiration_date, "must be in the future")
    end
  end

end
