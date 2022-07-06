class BookingsController < Spina::ApplicationController
  def new
    render inertia: 'booking'
  end

end