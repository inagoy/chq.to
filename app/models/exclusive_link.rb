class ExclusiveLink < Link
  validates_presence_of :password

  def authenticated?(password)
    self.password == password
  end
end
