require 'spec_helper'

describe User do
  it "has a valid factory" do
    create(:user).should be_valid
  end
  
  it "has a valid admin factory" do
    create(:admin).should be_valid
  end
  
  let(:user) { build_stub(:user) }
  it { should validate_presence_of :email }
  it {
    create(:user)
    should validate_uniqueness_of :email
  }
end