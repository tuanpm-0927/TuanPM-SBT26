class BookingsController < ApplicationController
  def new
    @booking = Booking.new
    @tour = params[:tour_id]
  end
  
  def create
    
  end
end
