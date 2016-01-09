Foyer.identity_provider = :developer if Rails.env.development?
Foyer.user_finder = ->(user_id) { User.new(id: user_id) }
