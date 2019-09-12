# frozen_string_literal: true

module UsersHelper
  def check_paymented(booking)
    return true if booking.paid?
  end
  
  def age dob
    now = Date.today
    now.year - dob.year - (now.strftime("%m%d") < dob.strftime("%m%d") ? 1 : 0)
  end
end
