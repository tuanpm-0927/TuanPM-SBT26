require "rails_helper"

RSpec.describe Image type: :model do
  describe "associations" do
    it "belongs to tour" do
      is_expected.to belong_to(:tour)
    end
  end
end
