require "rails_helper"

RSpec.describe Rating, type: :model do
  describe "associations" do
    it "belongs to user" do
      is_expected.to belong_to(:user)
    end

    it "belongs to category" do
      is_expected.to belong_to(:category)
    end

    it "has many likes" do
      is_expected.to have_many(:likes).dependent :destroy
    end

    it "has many comments" do
      is_expected.to have_many(:comments).dependent :destroy
    end
  end
end
