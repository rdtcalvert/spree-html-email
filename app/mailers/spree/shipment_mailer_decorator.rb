Spree::ShipmentMailer.class_eval do
  layout 'spree/layouts/email'
  helper 'spree/base'

  def shipped_email(shipment, resend = false)
    @shipment = shipment.respond_to?(:id) ? shipment : Spree::Shipment.find(shipment)
    subject = (resend ? "[#{Spree.t(:resend).upcase}] " : '')
    if @shipment.order.ship_address.country.name != "Slovenija"
      @translation = YAML.load_file('config/shipping-eu.yml')
    else
      @translation = YAML.load_file('config/shipping-slo.yml')
    end
    if @shipment.shipping_method.name == "Osebni prevzem"
      subject_part = Spree.t('shipment_mailer.shipped_email.osebni_prevzem_subject')
    else
      subject_part = @translation['map']['shipment_mailer']['shipped_email']['subject']
    end
    subject += "#{Spree::Config[:site_name]} #{subject_part} ##{@shipment.order.number}"
    mail(to: @shipment.order.email, from: from_address, subject: subject)
  end
end
