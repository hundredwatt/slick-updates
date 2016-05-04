require 'rails_helper'

RSpec.describe QuestionsController, :type => :controller do

  before(:each) do
    @user = create(:user)
    @update_form = create(:update_form, user: @user)
    @update_form.questions.create(text: "What you have done today?")
    @new_user = create(:user)
  end
  
  let(:create_params) { {update_form_id: @update_form.id, question: {text: 'any road block?'}}}
  
  describe "GET #index" do  
    it "should get all questions of update form for authorized user" do
      sign_in @user
      get :index, { update_form_id: @update_form.id }
      expect(response.status).to eql 200
      
    end
    
    it "should not allow for un authorized user" do
      sign_in @new_user
      get :index, { update_form_id: @update_form.id }
      expect(response.status).to eql 302
    end
    
    it "shoule get all question for invited user" do
      @update_form.collaborators.create(user_id: @new_user.id)
      sign_in @new_user
      get :index, { update_form_id: @update_form.id }
      expect(response.status).to eql 200
    end
  end
  
  describe "POST #create" do
    it "should create new question for update_form via authorized user" do
      sign_in @user
      expect{
        post :create, create_params
      }.to change{@update_form.questions.count}.by(1)
    end
    
    it "should not allow an unauthorized user to create new question for update_form" do
      sign_in @new_user
      post :create, create_params
      expect(response.status).to eql 302
    end
    
    it "should allow collaborator to create new question for update_form" do
      @update_form.collaborators.create(user_id: @new_user.id)
      sign_in @new_user
      expect{ post :create, create_params }.to change{@update_form.questions.count}.by(1)
      expect(response.status).to eql 204
    end
    
  end
  
  describe "DELETE #destroy" do
    it "should delete the question" do
      sign_in @user
      question = @update_form.questions.first
      delete :destroy, { :update_form_id => @update_form.id, :id => question.id }
      expect(response.status).to eql 204
      expect(@update_form.questions.count).to eql 0
    end
    
    it "should allow to delete the question for collaborator " do
      sign_in @new_user
      @update_form.collaborators.create(user_id: @new_user.id)
      question = @update_form.questions.first
      delete :destroy, { :update_form_id => @update_form.id, :id => question.id }
      expect(response.status).to eql 204
      expect(@update_form.questions.count).to eql 0
    end
    
    it "should not allow to delete for an unauthorized user" do
      sign_in @new_user
      question = @update_form.questions.first
      expect{
        delete :destroy, { :update_form_id => @update_form.id, :id => question.id }
      }.to change{@update_form.questions.count}.by(0)
      expect(@update_form.questions.count).to eql 1
    end
  end
end
