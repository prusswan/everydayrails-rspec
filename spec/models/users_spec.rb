require 'spec_helper'

describe User do
  it "has a valid factory" do
    create(:user).should be_valid
  end
  
  it "has a valid admin factory" do
    create(:admin).should be_valid
  end
end