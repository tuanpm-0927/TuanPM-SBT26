class Admin::BookingsController < ApplicationController
  def index
    @bookings = Booking.query_by_tourdetail(params[:tourdetail_id]).
      paginate(page: params[:page], per_page: Settings.per_page)
    authorize @bookings
  end
end
