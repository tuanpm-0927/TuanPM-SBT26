require "rails_helper"

RSpec.describe Banking type: :model do
  describe "associations" do
    it "has many payments" do
      is_expected.to have_many(:payments).dependent :destroy
    end
  end
end
