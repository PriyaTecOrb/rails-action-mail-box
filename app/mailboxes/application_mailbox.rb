class ApplicationMailbox < ActionMailbox::Base
  # routing /something/i => :somewhere
  # routing /reply/+.+/i  =>  :replies

  routing :all => :feedbacks
  # RECIPIENT_FORMAT = /feedback\-(.+)@example.com/i
end
