class Admin::BookingsController < ApplicationController
  authorize_resource
  
  before_action :load_booking, only: :show

  def index
    @q = Booking.ransack(params[:q]) 
    @bookings = if params[:q].nil?
      Booking
    else
      @bookings = @q.result(distinct: true)
    end.order_by_newest.paginate page: params[:page], per_page: Settings.def_perpage
    
    authorize @bookings
  end

  def show; end

  def booking_by_tour
    @bookings = Booking.query_by_tourdetail(params[:id]).
      paginate(page: params[:page], per_page: Settings.per_page)
  end

  private 
    def load_booking
      @booking = Booking.find_by(id: params[:id])
      return if @booking
      flash[:danger] = t ".booking_notfound"
      redirect_to notfound_path
    end
end
