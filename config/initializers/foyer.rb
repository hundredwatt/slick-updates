Foyer.identity_provider = Rails.env.development? ? :developer : :google
Foyer.user_finder = ->(user_id) { User.find_by(id: user_id) }
