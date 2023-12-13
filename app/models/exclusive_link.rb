class ExclusiveLink < Link
  validates_presence_of :password
  before_create :encrypt_password
  before_update :encrypt_password

  def authenticated?(password)
    BCrypt::Password.new(self.password) == password
  end

  private

  def encrypt_password
    self.password = BCrypt::Password.create(password)
  end

end
