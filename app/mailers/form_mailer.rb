class FormMailer < ApplicationMailer
  def form_email
    @text = params[:text]
    @email = params[:email]
    @name = params[:name]
    @account = params[:account]
    @locale = params[:locale].to_s
    
    subject = if @locale == 'en'
      "Inquiry from #{@account.name} website"
    elsif @locale == 'de'
      "Anfrage über #{@account.name} Webseite"
    elsif @locale == 'es'
      "Inquiry from #{@account.name} website"
    end

    mail(to: @account.email, subject: subject, reply_to: @email)
  end
end
