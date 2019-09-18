require "spec_helper"

RSpec.describe "admin/tours/new.html.erb", type: :view do
  let(:tour) {FactoryBot.build :tour}
  let(:categories) {Category.all}
  subject {rendered}

  before do
    assign :tour, tour
    assign :categories, categories
    render
  end

  it {is_expected.to have_content I18n.t("admin.tour.new.title")}

  describe "form" do
    it {assert_select "form[action*=?]", admin_tour_path}

    it {is_expected.to have_field "tour_title"}

    it {is_expected.to have_field "tour_content"}

    it {is_expected.to have_field "tour_address_source"}

    it {is_expected.to have_field "tour_address_distance"}

    it {is_expected.to have_field "tour_price"}

    it {is_expected.to have_field "tour_discount"}
    
    it {is_expected.to have_field "tour_price_discount"}

    it {is_expected.to have_field "tour_total_day"}

    it {is_expected.to have_field "tour_total_member_max"}

    it {is_expected.to have_field "tour_total_member_current"}

    it {is_expected.to have_field "tour_rating_average"}

    it {is_expected.to have_field "tour_category_id"}

    it {is_expected.to have_selector "input", class: "btn btn-primary"}

    it {is_expected.to render_template(partial: "_form")}
  end
end

