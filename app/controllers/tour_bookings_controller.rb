class TourBookingsController < ApplicationController
  before_action :load_tour, only: [:tour, :show]

  def tour
    @tourbookings = @tour.tourdetails
  end

  def new_booking
    @tourdetail = Tourdetail.find_by(id: params[:tour_detail_id])
  end

  def create_booking
    load_tour_detail(params[:booking][:tourdetail_id])
    unless @tourdetail.check_booking
      flash.now[:danger] = t ".booking_user_max"
      render :new_booking
    end
    infomation_booking = Informationbooktour.new params_infomation
    if infomation_booking.save
      booking = Booking.new params_booking
      booking.informationbooktour_id = infomation_booking.id
      if booking.save
        flash[:success] = ".booking_success"
        redirect_to userbooking_path
      end
    else
      flash.now[:danger] = t ".booking_error"
      byebug
      render :new_booking
    end
  end

  def destroy
    @booking = Booking.find_by(id: params[:booking_id])
    unless @booking
      flash[:danger] = ".delete_booking_failed"
    else
      flash[:success] = ".delete_booking_success"
    end
    redirect_to userbooking_path
  end

  def show
    if params[:tour_detail_id]
      @tour_detail_current = Tourdetail.find_by(id: params[:tour_detail_id])
    else
      @tour_detail_current = @tour.tourdetails.day_early_current.order_early_current.first
    end
    unless @tour_detail_current
      flash[:danger] = t ".notfound_tour_current"
    end
  end

  private
  def params_booking
    params.require(:booking).permit(:user_id, :tourdetail_id)
  end

  def params_infomation
    params.require(:booking).permit(:fullname, :phonenumber, :address, :note)
  end

  def load_tour_detail(id)
    @tourdetail = Tourdetail.find_by(id: id)
    unless @tourdetail
      flash[:danger] = t ".tour_detail_notfound"
      redirect_to notfound_path
    end
  end

  def load_tour
    @tour = Tour.find_by(id: params[:id])
    unless @tour
      flash[:danger] = t ".tour_notfound"
      redirect_to notfound_path
    end
  end
end
