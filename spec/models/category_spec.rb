require "rails_helper"

RSpec.describe Category, type: :model do
  let(:category) {FactoryBot.create :category}
  subject {category}
  
  before{category.save}

  it "should be valid" do
    expect(category).to be_valid
  end

  describe "#name" do
    it{is_expected.to validate_presence_of :name}
    it{is_expected.to validate_length_of(:name).
      is_at_most Settings.length_max_category_name}

    context "when the name is empty" do
      before{category.name = nil}
      it_behaves_like "when empty", :name
    end

    context "when the name is too long" do
      before{category.name = Faker::name * 1000}
      it_behaves_like "too long", :name, Settings.length_max_category_name
    end
  end
end
