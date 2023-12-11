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
  email: 'example@example.com',
  password: 'example',
  password_confirmation: 'example',
  username: 'example_user'
)
# Create link
Link.create!(
  name: 'Example Link',
  url: 'https://www.goole.com',
  type: 'RegularLink',
  user_id: 1,
)
# Create visits for a link
(1..100).each do |i|
  (1..rand(1..5)).each do
    Visit.create!(
      ip: '127.0.0.1',
      created_at: Time.now - i.days,
      updated_at: Time.now - i.days,
      link_id: 1)
  end
end
