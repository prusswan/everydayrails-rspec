require 'spec_helper'

describe Phone do
  it "has a valid factory" do
    create(:phone).should be_valid
  end
  
  it "does not allow duplicate phone numbers per contact" do
    contact = FactoryGirl.create(:contact)
    create(:home_phone, 
      contact: contact, 
      phone: "785-555-1234")
    build(:work_phone, 
      contact: contact, 
      phone: "785-555-1234").should_not be_valid
  end
  
  it "allows two contacts to share a phone number" do
    create(:home_phone, 
      phone: "785-555-1234")
    build(:home_phone, 
      phone: "785-555-1234").should be_valid
  end
end