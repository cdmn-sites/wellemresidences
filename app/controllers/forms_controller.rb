class FormsController < ApplicationController
  def create
    return redirect_back(fallback_location: '/') unless params[:not_a_bot]
    FormMailer.with(email: params[:email], name: params[:name], text: params[:text], locale: I18n.locale, account: Current.account).form_email.deliver_now
    flash[:success] = true
    redirect_back fallback_location: '/'
  end
end
