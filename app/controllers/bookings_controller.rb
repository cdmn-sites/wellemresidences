class BookingsController < Spina::ApplicationController
  def new
    render inertia: 'booking', props: {
      hidelayout: true
    }
  end

end