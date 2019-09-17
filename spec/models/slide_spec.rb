require "rails_helper"

RSpec.shared_examples "when empty" do |field|
  it do
    slide.save
    expect(slide.errors[field].first).to eql I18n.t("errors.messages.blank")
  end
end

RSpec.shared_examples "too long" do |field, count|
  it do
    slide.save
    expect(slide.errors[field].first).to eql I18n.t "errors.messages.too_long",
      count: count
  end
end

RSpec.describe Slide, type: :model do
  let(:slide) {FactoryBot.create :slide}
  subject {slide}
  
  before{slide.save}

  it "should be valid" do
    expect(slide).to be_valid
  end

  describe "#name" do
    it{is_expected.to validate_presence_of :name}
    it{is_expected.to validate_length_of(:name).
      is_at_most Settings.length_max_slidename}

    context "when the name is empty" do
      before{slide.name = nil}
      it_behaves_like "when empty", :name
    end

    context "when the name is too long" do
      before{slide.name = Faker::name * 1000}
      it_behaves_like "too long", :name, Settings.length_max_slidename
    end
  end
end
