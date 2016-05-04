require 'rails_helper'

RSpec.describe InvitesController, :type => :controller do

  
  before(:each) do
    @user = create(:user)
    @update_form = create(:update_form, user: @user)
    @new_user = create(:user)
    sign_in @user
  end
  
  let(:params) { {:invite_user_email => "user2@gmail.com"}}
  
  describe "POST #create" do

    it "should create new user and add as a collaborator to update_form" do
      user_count = User.count
      expect{
        post :create, { invite_user_email: "user2@gmail.com", update_form_id: @update_form.id }
      }.to change{@update_form.collaborators.count}.by(1)
     
      new_user = User.find_by_email("user2@gmail.com")
      expect(new_user.id).to eq(@update_form.collaborators.first.user_id)
      expect(User.count).to eq(user_count + 1)
    end
    
    it "should invite an already exist user to udpate form" do
      @new_user = create(:user)
      expect {
        post :create, { invite_user_email: @new_user.email, update_form_id: @update_form.id }
      }.to change{ @update_form.collaborators.count}.by(1)
      
      expect(@new_user.id).to eq(@update_form.collaborators.first.user_id)
    end

    it "should not invite an already invited user again to udpate form" do
      @new_user = create(:user)
      @update_form.collaborators.create(user_id: @new_user.id)
      
      expect {
        post :create, { invite_user_email: @new_user.email, update_form_id: @update_form.id }
      }.to change{ @update_form.collaborators.count}.by(0)

    end
  end
  
  describe "DELETE #destroy" do

    it "should destroy a collaborator from the update_form" do
      collaborator = @update_form.collaborators.create(user_id: @user.id)
      expect(@update_form.collaborators.count).to eql 1
      delete :destroy, { update_form_id: @update_form.id, id: collaborator.id }
      expect(@update_form.collaborators.count).to eql 0
    end
    
    it "should not allow an unauthorized user to delete a collaborator on update_form" do
      sign_in @new_user
      collaborator = @update_form.collaborators.create(user_id: @user.id)
      expect{
        delete :destroy, { update_form_id: @update_form.id, id: collaborator.id }
      }.to change{@update_form.collaborators.count}.by(0)
    end
  end

end
