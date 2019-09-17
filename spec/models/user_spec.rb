require "rails_helper"

RSpec.shared_examples "when empty" do |field|
  it do
    user.save
    expect(user.errors[field].first).to eql I18n.t("errors.messages.blank")
  end
end

RSpec.shared_examples "too long" do |field, count|
  it do
    user.save
    expect(user.errors[field].first).to eql I18n.t "errors.messages.too_long",
      count: count
  end
end

RSpec.describe User, type: :model do
  let(:user) {FactoryBot.create :user}
  subject {user}
  
  before{user.save}

  it "should be valid" do
    expect(user).to be_valid
  end

  describe "#full_name" do
    it{is_expected.to validate_presence_of :fullname}
    it{is_expected.to validate_length_of(:fullname).
      is_at_most Settings.length_max_name}

    context "when the full_name is empty" do
      before{user.fullname = nil}
      it_behaves_like "when empty", :fullname
    end

    context "when the name is too long" do
      before{user.fullname = Faker::name * 1000}
      it_behaves_like "too long", :fullname, Settings.length_max_name
    end
  end

  describe "#address" do
    it{is_expected.to validate_presence_of :address}
    it{is_expected.to validate_length_of(:address).
      is_at_most Settings.length_max_address}

    context "when the address is empty" do
      before{user.address = nil}
      it_behaves_like "when empty", :address
    end

    context "when the address is too long" do
      before{user.address = Faker::Address.city * 1000}
      it_behaves_like "too long", :address, Settings.length_max_address
    end
  end

  describe "#birthday" do
    it{is_expected.to validate_presence_of :birthday}

    context "when the birthday is larger than today" do
      before {user.birthday = DateTime.now.to_date.next_day(1)}
      it do
        user.save
        expect(user.errors[:birthday].first).to eql I18n.
          t("activerecord.errors.models.user.birthday_invalid")
      end
    end

    context "when the birthday is smaller than n year old" do
      before {user.birthday = DateTime.now.to_date.next_year(-5)}
      it do
        user.save
        expect(user.errors[:birthday].first).to eql I18n.
          t("activerecord.errors.models.user.birthday_invalid")
      end
    end
  end

  describe "#phonenumber" do
    it{is_expected.to validate_presence_of :phonenumber}
    it{is_expected.to validate_length_of(:phonenumber).
      is_at_most Settings.length_max_phonenumber}

    context "when the phonenumber is empty" do
      before{user.phonenumber = nil}
      it_behaves_like "when empty", :phonenumber
    end

    context "when the phonenumber is too long" do
      before{user.phonenumber = Faker::PhoneNumber.phone_number * 1000}
      it_behaves_like "too long", :phonenumber, Settings.length_max_phonenumber
    end
  end
end 
