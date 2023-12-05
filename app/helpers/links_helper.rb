module LinksHelper
  def self.encode(int)
    chars = [*'A'..'Z', *'a'..'z', *'0'..'9', '_', '!']
    digits = int.digits(64).reverse
    digits.map { |i| chars[i] }.join
  end
end
