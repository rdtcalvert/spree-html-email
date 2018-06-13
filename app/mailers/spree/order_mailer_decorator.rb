Spree::OrderMailer.class_eval do
  helper 'spree/base'
  layout 'spree/layouts/email'

  def confirm_email(order, resend = false)
    @order = order.respond_to?(:id) ? order : Spree::Order.find(order)
    @translation = translation_for_order_country
    subject = (resend ? "[#{Spree.t(:resend).upcase}] " : '')
    subject += "#{Spree::Store.current.name} #{@translation['map']['order_mailer']['confirm_email']['subject']} ##{@order.number}"
    mail(to: @order.email, from: from_address, subject: subject)
  end

  def cancel_email(order, resend = false)
    @order = order.respond_to?(:id) ? order : Spree::Order.find(order)
    @translation = translation_for_order_country
    subject = (resend ? "[#{Spree.t(:resend).upcase}] " : '')
    subject += "#{Spree::Store.current.name} #{@translation['map']['order_mailer']['cancel_email']['subject']} ##{@order.number}"
    mail(to: @order.email, from: from_address, subject: subject)
  end

  def comment_email(order)
      #find_order(order)
      @order = order.respond_to?(:id) ? order : Spree::Order.find(order)
      subject = "#{Spree::Config[:site_name]} Novo sporočilo v zvezi z naročilom ##{@order.number}"
      mail(:to => @order.email, :from => from_address, :subject => subject)
  end

  def translation_for_order_country
    if @order.ship_address.country.name != "Slovenija"
      YAML.load_file('config/shipping-eu.yml')
    else
      YAML.load_file('config/shipping-slo.yml')
    end
  end
end
