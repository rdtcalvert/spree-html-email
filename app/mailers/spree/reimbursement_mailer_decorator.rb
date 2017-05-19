Spree::ReimbursementMailer.class_eval do
  helper 'spree/base'
  layout 'spree/layouts/email'

  def reimbursement_email(reimbursement, resend = false)
    @reimbursement = reimbursement.respond_to?(:id) ? reimbursement : Spree::Reimbursement.find(reimbursement)
    subject = (resend ? "[#{Spree.t(:resend).upcase}] " : '')
    subject += "#{Spree::Store.current.name} #{Spree.t('reimbursement_mailer.reimbursement_email.subject')} ##{@reimbursement.order.number}"
    mail(to: @reimbursement.order.email, from: from_address, subject: subject)
  end
end
