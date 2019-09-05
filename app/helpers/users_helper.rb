# frozen_string_literal: true

module UsersHelper
  def check_paymented(booking)
    return true if booking.paid?
  end
end
