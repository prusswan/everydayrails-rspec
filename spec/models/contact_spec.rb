require 'spec_helper'

describe Contact do
  RSpec::Matchers.define :be_named do |expected|
    match do |actual|
      actual.name == expected
    end
    description do
      "return a full name as a string"
    end
  end
    
  subject{ create(:contact, firstname: "John", lastname: "Doe") }
  it { should be_named 'John Doe' }
  it { should have(3).phones }  
  specify { subject.should validate_presence_of :firstname }
  specify { subject.should validate_presence_of :lastname }
  specify { subject.should validate_presence_of :email }
  specify { subject.should validate_uniqueness_of :email }  
    
  describe "filter last name by letter" do      
    let!(:smith) { create(:contact, lastname: "Smith") }
    let!(:jones) { create(:contact, lastname: "Jones") }
    let!(:johnson) { create(:contact, lastname: "Johnson") }
    
    context "matching letters" do
      it "returns a sorted array of results that match" do
        Contact.by_letter("J").should == [johnson, jones]
      end
    end
    
    context "non-matching letters" do
      it "doesn't return contacts that don't start with a given letter" do
        Contact.by_letter("J").should_not include smith
      end
    end
  end
  
  
  let(:contact) { create(:contact) }
  let(:invalid_contact) { build(:invalid_contact) }
  
  specify{ contact.should be_valid }
  specify{ invalid_contact.should_not be_valid }
end