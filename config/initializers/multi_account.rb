class ActiveRecord::Base
  default_scope do
    current_account_id = Current.account.try(:id)
    attribute_names.include?('account_id') && current_account_id ? where(account_id: current_account_id) : all
  end

  before_create do
    if respond_to?(:account_id)
      self.account_id ||= Current.account.id || Spina::Account.first.id
    end
  end
end

class ActionMailer::Base
  default from: "info@cdmn.de"
  before_action :set_host_from_user
  
  def set_host_from_user
    # TODO: somehow get the account from email
    # ActionMailer::Base.default_url_options[:host] = Current.account.domain || "#{Current.account.subdomain}.cdmn.de"
    ActionMailer::Base.default_url_options[:host] = Rails.env.development? ? 'localhost:3000' : 'cdmn.de'
  end
end