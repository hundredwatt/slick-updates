Foyer.identity_provider = Rails.env.development? ? :developer : :google
Foyer.user_finder = ->(user_id) { User.new(id: user_id) }
