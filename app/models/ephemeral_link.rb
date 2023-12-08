class EphemeralLink < Link
  def accessible?
    self.visits.count == 0
  end
end
