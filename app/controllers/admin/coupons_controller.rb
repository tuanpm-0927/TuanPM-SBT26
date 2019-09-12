class Admin::CouponsController < ApplicationController
  before_action :load_coupon, except: [:index, :create, :new]

  def index
    @coupons = Coupon.paginate(page: params[:page], per_page:  Settings.def_perpage)
    authorize @coupons
  end

  def create 
    @coupon = Coupon.new coupon_params
    authorize @coupon
    if @coupon.save
      @check_create = true
      load_coupons
    else
      @check_create = false
    end
    respond_to do |format|
      format.js
    end
  end

  def new
    @coupon = Coupon.new
    authorize @coupon
    respond_to do |format|
      format.js
    end
  end

  def edit
    authorize @coupon
    respond_to do |format|
      format.js
    end
  end

  def update
    authorize @coupon
    if @check_update = @coupon.update_attributes(coupon_params)
      flash[:success] = t ".slide_update_success"
    end
    respond_to do |format|
      format.js
    end
  end

  def destroy
    authorize @coupon
    if @coupon.destroy
      flash[:success] = t ".delete_success"
      redirect_to admin_coupons_path
    end
  end

  private 
  def coupon_params
    params.require(:coupon).permit(:coupon, :value)
  end

  def load_coupon
    @coupon = Coupon.find_by(id: params[:id])
    unless @coupon
      flash.now[:danger] = t ".coupon_notfound"
      redirect_to notfound_path
    end
  end

  def load_coupons
    @coupons = Coupon.paginate(page: Settings.def_page, per_page: Settings.def_perpage)
  end

end
