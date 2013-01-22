require 'spec_helper'

describe UsersController do
  
  let(:user) { create(:user) }
  let(:admin) { create(:admin) }
  
  describe 'guest access' do
    it "GET#index redirects to the login form" do
      get :index
      response.should require_login
    end
    
    it "GET#new redirects to the login form" do
      get :new
      response.should require_login
    end
    
    it "POST#create redirects to the login form" do
      post :create, user: attributes_for(:user)
      response.should require_login
    end 
  end
  
  describe 'user access' do
    before :each do
      session[:user_id] = user.id
    end
    
    it "GET#index denies access" do
      get :index
      response.should deny_access
    end
    
    it "GET#new denies access" do
      get :new
      response.should deny_access
    end
    
    it "POST#create denies access" do
      post :create, user: attributes_for(:user)
      response.should deny_access
    end
  end
  
  describe 'admin access' do
    before :each do
      session[:user_id] = admin.id
    end
    
    describe 'GET#index' do
      it "collects users into @users" do
        admin
        user
        get :index
        assigns(:users).should == [admin,user]
      end
      
      it "renders the :index template" do
        get :index
        response.should render_template :index
      end
    end
    
    describe 'GET#new' do
      it "sets up a new, empty user" do
        get :new
        assigns(:user).should be_a_new(User)
      end
      
      it "renders the :new template" do
        get :new
        response.should render_template(:new)
      end
    end
    
    describe 'POST#create' do
      context "with valid attributes" do
        it "adds the user" do
          expect{
            post :create, user: attributes_for(:user)
          }.to change(User, :count).by(1)
        end
        
        it "redirects to users#index" do
          post :create, user: attributes_for(:user)
          response.should redirect_to users_url
        end
      end
    end
    
    describe 'GET#show' do
      it "assigns the user to @user" do
        new_user = double(User)
        new_user.stub(:new_record?) { false }
        new_user.stub(:admin?) { false }
        User.stub(:find) { new_user }
        get :show, id: new_user.to_param
        assigns(:user).should == new_user
      end
    end
    
  end
  
end