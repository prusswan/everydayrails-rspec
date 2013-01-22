require 'spec_helper'

describe 'User management' do
  it "adds a new user" do
    admin = create(:admin)
    sign_in admin
    
    visit root_path
    expect{
      click_link 'Users'
      click_link 'New User'
      fill_in 'Email', with: 'newuser@example.com'
      fill_in 'Password', with: 'secret123'
      fill_in 'Password confirmation', with: 'secret123'
      click_button 'Create User'
    }.to change(User, :count).by(1)
    current_path.should == users_path
    page.should have_content 'New user created'
    within 'h1' do
      page.should have_content 'Users'
    end
    page.should have_content 'newuser@example.com'
  end
end