class RepliesMailbox < ApplicationMailbox
  # mail = Mail.new
  RECIPIENT_FORMAT = /feedback\-(.+)@example.com/i

  before_processing :user
  def process
    # byebug
    Rails.logger.info "=========sds==#{mail.inspect}" 
    if mail.parts.present?
      Feedback.create user_id: @user.id, product_id: product_id, content: mail.body.decoded
    else
      Feedback.create user_id: @user.id, product_id: product_id, content: mail.decoded
    end
  end

  def user
    @user ||= User.find_by_email(mail.from)
  end

  def product_id
    # There can be multiple recipients, 
    # so finding the one which matches the RECEIPIENT_FORMAT
    
    recipient = mail.recipients.find { |r| RECIPIENT_FORMAT.match?(r) }

    Rails.logger.info "====#{mail.recipients}=#{recipient.inspect}"
    
    # Returns the first_match and that is product_id
    # For Ex: recipient = "feedback-1234@example.com"
    # Then it'll return 1234
    # recipient[RECIPIENT_FORMAT, 1]
  end
end
