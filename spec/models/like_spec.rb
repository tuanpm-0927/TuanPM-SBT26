require "rails_helper"

RSpec.describe Like, type: :model do
  describe "associations" do
    it "belongs to user" do
      is_expected.to belong_to(:user)
    end
  end
end
