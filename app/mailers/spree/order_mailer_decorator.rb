Spree::OrderMailer.class_eval do
  helper 'spree/base'
  layout 'spree/layouts/email'

  def comment_email(order)
      #find_order(order)
      @order = order.respond_to?(:id) ? order : Spree::Order.find(order)
      subject = "#{Spree::Config[:site_name]} Novo sporočilo v zvezi z naročilom ##{@order.number}"
      mail(:to => @order.email, :from => from_address, :subject => subject)
  end
end
