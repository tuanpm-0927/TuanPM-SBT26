require "rails_helper"

RSpec.describe Booking type: :model do
  describe "associations" do
    it "belongs to user" do
      is_expected.to belong_to(:user)
    end

    it "belongs to tourdetail" do
      is_expected.to belong_to(:tourdetail)
    end

    it "belongs to informationbooktour" do
      is_expected.to belong_to(:informationbooktour)
    end
    
    it "has many payment" do
      is_expected.to have_many(:payments).dependent :destroy
    end
  end
end
