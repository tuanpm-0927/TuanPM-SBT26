require "rails_helper"

RSpec.shared_examples "when empty" do |field|
  it do
    category.save
    expect(category.errors[field].first).to eql I18n.t("errors.messages.blank")
  end
end

RSpec.shared_examples "too long" do |field, count|
  it do
    category.save
    expect(category.errors[field].first).to eql I18n.t "errors.messages.too_long",
      count: count
  end
end

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
