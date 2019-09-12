class TourBookingsController < ApplicationController
  include ChatworkHelper
  before_action :load_tour, only: [:tour, :show]
  before_action :load_booking, only: [:destroy]

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
      byebug
      render :new_booking
    else
      begin
        ActiveRecord::Base.transaction do
          info_user = Informationbooktour.new params_infomation
          info_user.save!
          booking = Booking.new params_booking
          booking.total_money = @tourdetail.tour.price_discount
          booking.informationbooktour_id = info_user.id
          if booking.save!
            if @tourdetail.update_attribute(:total_current_booking, @tourdetail.total_current_booking + 1)
              flash[:success] = t ".booking_success"
              message = t ".notification_booking", name: @tourdetail.tour.title, price: booking.total_money,
                status: booking.status, link_info: ""
              ChatWorkMess.new.send_message message
            else
              flash[:danger] = t ".booking_error"
            end
          else
            flash.now[:danger] = t ".booking_error"
            render :new_booking
          end
        rescue ActiveRecord::RecordInvalid => exception
          flash[:danger] = t ".booking_failed"
        end
      end
      redirect_to userbooking_path
    end
  end

  def destroy
    authorize! :destroy, @booking
    unless @booking
      flash[:danger] = t ".delete_booking_failed"
    else
      ActiveRecord::Base.transaction do
        @booking.tourdetail.update_attribute(:total_current_booking, @booking.tourdetail.total_current_booking - 1)
        tourdetail = @booking.tourdetail
        if @booking.destroy
          message = t ".destroy_booking", name: tourdetail.tour.title, user: @booking.user.fullname
          ChatWorkMess.new.send_message message 
          flash[:success] = t ".delete_booking_success"
        else
          flash[:danger] = t ".delete_booking_failed"
        end
        rescue ActiveRecord::RecordInvalid => exception
          flash[:danger] = t ".booking_failed"
        end
    end
    redirect_to userbooking_path
  end

  def show
    if params[:tour_detail_id]
      @tour_detail_current  = Tourdetail.find_by(id: params[:tour_detail_id])
    else
      @tour_detail_current = @tour.tourdetails.day_early_current.order_early_current.first
    end
    unless @tour_detail_current
      flash[:danger] = t ".notfound_tour_current"
      redirect_to notfound_path
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

  def load_booking
    @booking = Booking.find_by(id: params[:id])
  end

  def load_tour
    @tour = Tour.find_by(id: params[:id])
    unless @tour
      flash[:danger] = t ".tour_notfound"
      redirect_to notfound_path
    end
  end
end
