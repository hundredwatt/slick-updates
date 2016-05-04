require 'rails_helper'

RSpec.describe Collaborator, :type => :model do
  
  it { should belong_to(:user) }
  it { should belong_to(:update_form) }
  it { should validate_uniqueness_of(:user_id).scoped_to(:update_form_id) }
end
