require 'rails_helper'

RSpec.describe User, type: :model do

  describe "validations" do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_length_of(:password) }
  end

  describe "#is_password?" do
    it "should check to see if password matches" do
      expect(User.password_digest)
    end
  end
end  
