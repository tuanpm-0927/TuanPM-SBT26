class Admin::BookingsController < ApplicationController
  authorize_resource

  before_action :load_booking, only: :update
  
  def index
    @q = Booking.ransack(params[:q]) 
    @bookings = if params[:q].nil?
      Booking.order_by_newest
    else
      @bookings = @q.result(distinct: true).order_by_newest
    end.paginate page: params[:page], per_page: Settings.def_perpage
  end

  def show
    @bookings = Booking.query_by_tourdetail(params[:id]).
      paginate(page: params[:page], per_page: Settings.per_page)
  end

  def update
    if @booking.update_attribute(:request, params[:request])
      flash[:success] = t ".update_success"
    else
      flash[:danger] = t ".update_failed"
    end
    redirect_to admin_bookings_path
  end

  private 
  def load_booking
    @booking = Booking.find_by(id: params[:id])
    return if @booking
    flash[:danger] = t ".notfound_booking"
    redirect_to notfound_path
  end
end
