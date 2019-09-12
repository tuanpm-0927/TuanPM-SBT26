require "rails_helper"

include "util.rb"


RSpec.describe Tourdetail, type: :model do
  describe "associations" do
    it "belongs to tour" do
      is_expected.to belong_to(:tour)
    end
  end
end
