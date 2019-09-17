require "rails_helper"

RSpec.shared_examples "when empty" do |field|
  it do
    tourdetail.save
    expect(tourdetail.errors[field].first).to eql I18n.t("errors.messages.blank")
  end
end


RSpec.describe Tourdetail, type: :model do
  describe "associations" do
    it "belongs to tour" do
      is_expected.to belong_to(:tour)
    end
  end
end
