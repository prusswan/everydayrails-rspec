require 'spec_helper'

describe ContactsController do
  
  describe "admin access" do
    before :each do
      @contact = create(:contact, firstname: 'Lawrence', lastname: 'Smith')
      
      user = create(:admin)
      session[:user_id] = user.id
    end
    
    describe 'GET #index' do    
      it "populates an array of contacts" do
        get :index
        assigns(:contacts).should eq([@contact])
      end
    
      it "renders the :index view" do
        get :index
        response.should render_template :index
      end
    end
  
    describe 'GET #show' do    
      it "assigns the requested contact to @contact" do
        get :show, id: @contact
        assigns(:contact).should == @contact
      end

      it "renders the :show template" do
        get :show, id: @contact
        response.should render_template :show
      end
    end
  
    describe 'GET #new' do
      it "assigns a new Contact to @contact" do
        get :new
        assigns(:contact).should be_a_new(Contact)
      end
      
      it "assigns a home, office, and mobile phone to the new contact" do
        get :new
        assigns(:contact).phones.map do |p|
          p.phone_type
        end.should eq %w(home office mobile)
      end
      
      it "renders the :new template" do
        get :new
        response.should render_template :new
      end
    end
    
    describe 'GET #edit' do
      it "assigns the requested contact to @contact" do
        get :edit, id: @contact
        assigns(:contact).should == @contact
      end
      
      it "renders the :edit template" do
        get :edit, id: @contact
        response.should render_template :edit
      end
    end
  
    describe "POST #create" do
      before :each do
        @phones = [
          attributes_for(:phone, phone_type: "home"),
          attributes_for(:phone, phone_type: "office"),
          attributes_for(:phone, phone_type: "mobile")
        ]
      end
      
      context "with valid attributes" do
        it "creates a new contact" do
          expect{
            post :create, contact: attributes_for(:contact,
              phones_attributes: @phones)
          }.to change(Contact,:count).by(1)
        end

        it "redirects to the new contact" do
          post :create, contact: attributes_for(:contact,
            phones_attributes: @phones)
          response.should redirect_to Contact.last
        end
      end

      context "with invalid attributes" do
        it "does not save the new contact" do
          expect{
            post :create, contact: attributes_for(:invalid_contact)
          }.to_not change(Contact,:count)
        end

        it "re-renders the new method" do
          post :create, contact: attributes_for(:invalid_contact)
          response.should render_template :new
        end
      end 
    end
  
    describe 'PUT #update' do
      context "valid attributes" do
        it "located the requested @contact" do
          put :update, id: @contact, contact: attributes_for(:contact)
          assigns(:contact).should eq(@contact)      
        end

        it "changes @contact's attributes" do
          put :update, id: @contact, 
            contact: attributes_for(:contact, 
              firstname: "Larry", lastname: "Smith")
          @contact.reload
          @contact.firstname.should eq("Larry")
          @contact.lastname.should eq("Smith")
        end

        it "redirects to the updated contact" do
          put :update, id: @contact, contact: attributes_for(:contact)
          response.should redirect_to @contact
        end
      end

      context "invalid attributes" do
        it "locates the requested @contact" do
          put :update, id: @contact, contact: attributes_for(:invalid_contact)
          assigns(:contact).should eq(@contact)      
        end

        it "does not change @contact's attributes" do
          put :update, id: @contact, 
            contact: attributes_for(:contact, 
              firstname: "Larry", lastname: nil)
          @contact.reload
          @contact.firstname.should_not eq("Larry")
          @contact.lastname.should eq("Smith")
        end

        it "re-renders the edit method" do
          put :update, id: @contact, contact: attributes_for(:invalid_contact)
          response.should render_template :edit
        end
      end
    end
  
    describe 'DELETE destroy' do
      it "deletes the contact" do
        expect{
          delete :destroy, id: @contact        
        }.to change(Contact,:count).by(-1)
      end

      it "redirects to contacts#index" do
        delete :destroy, id: @contact
        response.should redirect_to contacts_url
      end
    end
  end
  
  
  describe "user access" do
    before :each do
      @contact = create(:contact, firstname: 'Lawrence', lastname: 'Smith')
      
      user = create(:user)
      session[:user_id] = user.id
    end
    
    describe 'GET #index' do    
      it "populates an array of contacts" do
        get :index
        assigns(:contacts).should eq([@contact])
      end
    
      it "renders the :index view" do
        get :index
        response.should render_template :index
      end
    end
  
    describe 'GET #show' do    
      it "assigns the requested contact to @contact" do
        get :show, id: @contact
        assigns(:contact).should == @contact
      end

      it "renders the :show template" do
        get :show, id: @contact
        response.should render_template :show
      end
    end
  
    describe 'GET #new' do
      it "assigns a new Contact to @contact" do
        get :new
        assigns(:contact).should be_a_new(Contact)
      end
      
      it "assigns a home, office, and mobile phone to the new contact" do
        get :new
        assigns(:contact).phones.map do |p|
          p.phone_type
        end.should eq %w(home office mobile)
      end
      
      it "renders the :new template" do
        get :new
        response.should render_template :new
      end
    end
    
    describe 'GET #edit' do
      it "assigns the requested contact to @contact" do
        get :edit, id: @contact
        assigns(:contact).should == @contact
      end
      
      it "renders the :edit template" do
        get :edit, id: @contact
        response.should render_template :edit
      end
    end
  
    describe "POST #create" do
      before :each do
        @phones = [
          attributes_for(:phone, phone_type: "home"),
          attributes_for(:phone, phone_type: "office"),
          attributes_for(:phone, phone_type: "mobile")
        ]
      end
      
      context "with valid attributes" do
        it "creates a new contact" do
          expect{
            post :create, contact: attributes_for(:contact,
              phones_attributes: @phones)
          }.to change(Contact,:count).by(1)
        end

        it "redirects to the new contact" do
          post :create, contact: attributes_for(:contact,
            phones_attributes: @phones)
          response.should redirect_to Contact.last
        end
      end

      context "with invalid attributes" do
        it "does not save the new contact" do
          expect{
            post :create, contact: attributes_for(:invalid_contact)
          }.to_not change(Contact,:count)
        end

        it "re-renders the new method" do
          post :create, contact: attributes_for(:invalid_contact)
          response.should render_template :new
        end
      end 
    end
  
    describe 'PUT #update' do
      context "valid attributes" do
        it "located the requested @contact" do
          put :update, id: @contact, contact: attributes_for(:contact)
          assigns(:contact).should eq(@contact)      
        end

        it "changes @contact's attributes" do          
          put :update, id: @contact, 
            contact: attributes_for(:contact, 
              firstname: "Larry", lastname: "Smith")
          @contact.reload
          @contact.firstname.should eq("Larry")
          @contact.lastname.should eq("Smith")
        end

        it "redirects to the updated contact" do
          put :update, id: @contact, contact: attributes_for(:contact)
          response.should redirect_to @contact
        end
      end

      context "invalid attributes" do
        it "locates the requested @contact" do
          put :update, id: @contact, contact: attributes_for(:invalid_contact)
          assigns(:contact).should eq(@contact)      
        end

        it "does not change @contact's attributes" do
          put :update, id: @contact, 
            contact: attributes_for(:contact, 
              firstname: "Larry", lastname: nil)
          @contact.reload
          @contact.firstname.should_not eq("Larry")
          @contact.lastname.should eq("Smith")
        end

        it "re-renders the edit method" do
          put :update, id: @contact, contact: attributes_for(:invalid_contact)
          response.should render_template :edit
        end
      end
    end
  
    describe 'DELETE destroy' do
      it "deletes the contact" do
        expect{
          delete :destroy, id: @contact        
        }.to change(Contact,:count).by(-1)
      end

      it "redirects to contacts#index" do
        delete :destroy, id: @contact
        response.should redirect_to contacts_url
      end
    end
  end
  
  
  describe "guest access" do
    describe 'GET #index' do
      before :each do
        @contact = create(:contact)
      end
    
      it "populates an array of contacts" do
        get :index
        assigns(:contacts).should eq([@contact])
      end
    
      it "renders the :index view" do
        get :index
        response.should render_template :index
      end
    end
  
    describe 'GET #show' do
      before :each do
        @contact = create(:contact)
      end
    
      it "assigns the requested contact to @contact" do
        get :show, id: @contact
        assigns(:contact).should == @contact
      end

      it "renders the :show template" do
        get :show, id: @contact
        response.should render_template :show
      end
    end
  
    describe 'GET #new' do
      it "requires login" do
        get :new
        response.should redirect_to login_url
      end
    end
  
    describe "POST #create" do
      it "requires login" do
        post :create, contact: attributes_for(:contact)
        response.should redirect_to login_url
      end
    end
  
    describe 'PUT #update' do
      it "requires login" do
        put :update, id: @contact, contact: attributes_for(:contact)
        response.should redirect_to login_url
      end
    end
  
    describe 'DELETE #destroy' do
      it "requires login" do
        delete :destroy, id: @contact
        response.should redirect_to login_url
      end
    end
  end
  
end
