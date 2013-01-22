require 'spec_helper'

describe "Contacts" do 
  describe 'View contacts' do
    before :each do
      @bob = create(:contact,
        firstname: 'Bob',
        lastname: 'Burns',
        email: 'bob@example.com')
      create(:contact, firstname: 'Bob', lastname: 'Conway')
    end
    
    it "lists a contact's information" do
      visit root_path
      click_link 'Bob Burns'
      within 'h1' do
        page.should have_content 'Bob Burns'
      end
      page.should have_content 'bob@example.com'
      @bob.phones.each do |phone|
        page.should have_content phone.phone
      end
    end
    
    it "filters contacts by letter" do
      visit contacts_url
      click_link 'B'
      page.should have_content 'Bob Burns'
      page.should_not have_content 'Bob Conway'
    end
  end
  
   
  describe "Manage contacts" do
    before :each do
      user = create(:user)
      sign_in(user)
    end
    
    it "adds a new contact and displays the results" do
      visit root_path
      expect{
        click_link 'New Contact'
        fill_in 'Firstname', with: "John"
        fill_in 'Lastname', with: "Smith"
        fill_in 'Email', with: 'johnsmith@example.com'
        fill_in 'home', with: "555-1234"
        fill_in 'office', with: "555-3324"
        fill_in 'mobile', with: "555-7888"
        click_button "Create Contact"
      }.to change(Contact,:count).by(1)
      
      page.should have_content "Contact was successfully created."
      page.should have_content "John Smith"
      page.should have_content "johnsmith@example.com"
      page.should have_content "home 555-1234"
      page.should have_content "office 555-3324"
      page.should have_content "mobile 555-7888"
    end
    
    it "edits a contact and displays the updated results" do
      contact = create(:contact, firstname: 'Sam', lastname: 'Smith')
      visit root_path
      within "#contact_#{contact.id}" do
        click_link 'Edit'
      end
      fill_in 'Firstname', with: 'Samuel'
      fill_in 'Lastname', with: 'Smith, Jr.'
      fill_in 'Email', with: 'samsmith@example.com'
      fill_in 'home', with: '123-555-1234'
      fill_in 'work', with: '123-555-3333'
      fill_in 'mobile', with: '123-555-7777'
      click_button 'Update Contact'
      
      page.should have_content 'Contact was successfully updated'
      page.should have_content 'Samuel Smith, Jr.'
      page.should have_content 'samsmith@example.com'
      page.should have_content '123-555-1234'
      page.should have_content '123-555-3333'
      page.should have_content '123-555-7777'
    end
    
    it "deletes a contact", js: true do
      contact = create(:contact, firstname: "Aaron", lastname: "Sumner")
      visit root_path
      expect{
        within "#contact_#{contact.id}" do
          click_link 'Destroy'
        end
        alert = page.driver.browser.switch_to.alert
        alert.accept
      }.to change(Contact,:count).by(-1)
      page.should have_content "Contacts"
      page.should_not have_content "Aaron Sumner"
    end
  end
end