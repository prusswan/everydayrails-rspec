require 'spec_helper'

describe Contact do
  it "has a valid factory" do
    create(:contact).should be_valid
  end
  
  it "has an invalid factory" do
    build(:invalid_contact).should_not be_valid
  end
  
  it "is invalid without a firstname" do
    build(:contact, firstname: nil).should_not be_valid
  end
  
  it "is invalid without a lastname" do
    build(:contact, lastname: nil).should_not be_valid
  end
  
  it "is invalid with a duplicate email address" do
    create(:contact, email: "aaron@everydayrails.com")
    build(:contact, 
      email: "aaron@everydayrails.com").should_not be_valid
  end
  
  it "returns a contact's full name as a string" do
    create(:contact, 
      firstname: "John", 
      lastname: "Doe").name.should == "John Doe"
  end
  
  it "has three phone numbers" do
    create(:contact).phones.count.should == 3
  end
  
  describe "filter last name by letter" do      
    before :each do
      @smith = create(:contact, lastname: "Smith")
      @jones = create(:contact, lastname: "Jones")
      @johnson = create(:contact, lastname: "Johnson")
    end

    context "matching letters" do
      it "returns a sorted array of results that match" do
        Contact.by_letter("J").should == [@johnson, @jones]
      end
    end
    
    context "non-matching letters" do
      it "doesn't return contacts that don't start with a given letter" do
        Contact.by_letter("J").should_not include @smith
      end
    end
  end
end