class FeedbacksMailbox < ApplicationMailbox
  # mail = Mail.new
  RECIPIENT_FORMAT = /feedback\-(.+)@example.com/i

  before_processing :user

  def process
    if mail.parts.present?
      Feedback.create! user_id: @user.id, product_id: product_id, content: mail.body.decoded
    else
      Feedback.create! user_id: @user.id, product_id: product_id, content: mail.decoded
    end
  end

  def user
    @user ||= User.find_by_email(mail.from)
  end

  def product_id  
    recipient = mail.recipients.find { |r| RECIPIENT_FORMAT.match?(r) }
    
    # Returns the first_match and that is product_id
    # For Ex: recipient = "feedback-3@example.com"
    recipient[RECIPIENT_FORMAT, 1]
  end
end
