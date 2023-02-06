class FeedbackMailer < ApplicationMailer
	default from: "testdilip01@gmail.com"

  def send_email
    mail(to: "priyadarshanimini@gmail.com", 
    	reply_to: "feedback-#{1}@#{'http://localhost:3000/'}", 
    	subject: 'Mailbox Test', 
    	body: 'Provide feedback for the product by replying to this mail')
  end
end
