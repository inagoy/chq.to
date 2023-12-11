# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Link.create(url: 'https://example.com/link2', link_category: 'temporal', user_id: 1, expiration_date: Time.zone.now + 1.minute)


# Create user
User.create!(
  email: 'juan@example.com',
  password: 'juan123',
  password_confirmation: 'juan123',
  username: 'juan_example'
)
User.create!(
  email: 'julia@example.com',
  password: 'julia123',
  password_confirmation: 'julia123',
  username: 'julia_example'
)

# Create link
Link.create!(
  name: 'Link Regular de Juan',
  url: 'https://www.google.com',
  type: 'RegularLink',
  user_id: 1,
)
Link.create!(
  name: 'Link Exclusive de Juan',
  url: 'https://www.github.com',
  type: 'ExclusiveLink',
  password: '123456',
  user_id: 1,
)
Link.create!(
  name: 'Link Temporary de Juan',
  url: 'https://www.twitter.com',
  type: 'TemporaryLink',
  expiration_date: Time.zone.now + 1.minute,
  user_id: 1,
)
Link.create!(
  url: 'https://www.youtube.com',
  type: 'EphemeralLink',
  user_id: 1,
)

# Create visits for a link except for ephemeral
=begin
(1..3).each do |i|
  (1..100).each do |j|
    (1..rand(1..5)).each do
      Visit.create!(
        ip: '127.0.0.1',
        created_at: Time.now - j.days,
        updated_at: Time.now - j.days,
        link_id: i)
    end
  end
end
=end
