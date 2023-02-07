## Create Action Mailbox using Ruby on Rails

We are creating a JavaScript countdown timer for the users so they can embed it into any websites via script tag

### Step 1: Setup rails project for the action mailbox


rails new rails-action-mail-box -d mysql

We are using mysql above

### Step 2: Install Devise gem for Manage Authentication Process

gem 'devise'

Now we install this gem by running command:

bundle install 

After that run command :

rails generate devise:install

### Step 3: Generate user model using Devise 
    
rails generate devise User 

### Step 4: Create and Migrate the databse


rails db:create

rails db:migrate

### Step 5: Generate Devise views for authentication process


rails generate devise:views users

Here we have customised devies view using bootstrap


### Step 6: Edit routes.rb and set root to counters#index:


# config/routes.rb
Rails.application.routes.draw do
 devise_scope :user do
    root to: "devise/sessions#new"
  end
  resources :products do
    resources :feedbacks
  end
  
  devise_for :users
end


### Step 7: Create a Action Mailbox for processing inbound emails:

  rails action_mailbox:install

  The above command generated ApplicationMailbox class looks like this.

  class ApplicationMailbox < ActionMailbox::Base
    # routing /something/i => :somewhere
  end
  
  # create  app/mailboxes/application_mailbox.rb

  # migration 20230203082508_create_active_storage_tables.active_storage.rb from active_storage
  # migration 20230203082509_create_action_mailbox_tables.action_mailbox.rb from action_mailbox


  Now run this below command:

  rails db:migrate

### Step 8: Now we can define routes for emails. For ex:

  class ApplicationMailbox < ActionMailbox::Base
	  # routing /something/i => :somewhere
	  routing  :all => :feedbacks
	end


### Step 9: Generate scaffold to create CURD for any entity

Here we are generating scaffold for the product and feedback.


rails generate scaffold Product title:string description:text price:string

rails generate scaffold Feedback contect:text user:references product:references  


### Step 10: Next, we generate feedback mailbox  

  rails g mailbox Feedbacks


  It's looks like this :

  class FeedbacksMailbox < ApplicationMailbox
  
	  def process
	  end
	  
	end

### Step 11: Lastly, we need to add protect_from_forgery except: [:show] in our counters_controller.rb to permit cross-origin JavaScript embedding for our show action.


#### Now you can embed the countdown timer widget on any site using the following script:

```
<script type=”text/javascript” src=”http://localhost:3000/counters/1.js"></script>
```