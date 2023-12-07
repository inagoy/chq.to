class TemporaryLink < Link
  validates_presence_of :expiration_date
  validate :expiration_date_in_future

  def in_time?
    Time.zone.now < expiration_date
  end

  private

  def expiration_date_in_future
    if expiration_date <= Time.zone.now
      errors.add(:expiration_date, "Must be in the future")
    end
  end
end
