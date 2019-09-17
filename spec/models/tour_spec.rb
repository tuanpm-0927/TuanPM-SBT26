require "rails_helper"

RSpec.describe Tour, type: :model do
  describe "associations" do
    it "belongs to category" do
      is_expected.to belong_to(:category)
    end

    it "has many image"
      is_expected.to have_many(:images).dependent :destroy

    it "has many ratings" do
      is_expected.to have_many(:ratings).dependent :destroy
    end
  end
end
