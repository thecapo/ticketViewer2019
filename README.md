# ticketViewer2019

Zendesk is a customer service tool that allows the creation and management of support tickets.
Your company needs you to build a Ticket Viewer that will:

  ● Connect to the Zendesk API
  ● Request the tickets for your account, page through tickets when more than 25 are
    returned
  ● Display them in a list
  ● Display individual ticket details

  #### How to use this app - Installation
    ● Get the app by going to github.com/thecapo/ticketViewer2019
      There are 2 ways to download it
        1. Cloning it - click the green button on the far right side with 'Clone or download', 
           copy the SSH key. In the terminal type: git clone git@github.com:thecapo/ticketViewer2019.git
           It will begin to download, once finished move to that folder.
        2. Downloading it - click the green button on the far right side with 'Clone or download',
           then click 'Download ZIP' 
           Unzip it then go to that folder.
    
    ● Once inside the folder, run 
      ```
      bundle install
      ```

    ● Once inside the folder, run the app by typing 
      ```
      $ rails s
      ```

    ● When the app is running enter 
      ```
      $ localhost:3000
      
      ```

  #### Possible routes to see tickets
    ● /tickets
    ● /tickets/:id
    ● /tickets/:ticket_id/next_page


  ##### Note
    ● Tickets are already prepopulated within my account.
  
  
  #### Gems used

    ● Fetching data
      ```
        HTTParty 
      ```

    ● Pagination
      ```
        will_paginate
      ```

    ● Testing 
      ```
        rspec
        vcr
        webmock 
      ```

    ```ruby sample code
    # app/controllers/tickets_controller.rb
    class TicketsController < ApplicationController
      def index
      response = HTTParty.get("https://{subdomain}.zendesk.com/api/v2/tickets?page=#{(params[:ticket_id])}", basic_auth: set_ticket, :headers => {'Content-Type' => 'application/json'} ) 
        if @ticketsParsed = response.parsed_response["tickets"]
          @tickets = @ticketsParsed.paginate(:page => params[:page], :per_page => 25)
        else
          render file: "#{Rails.root}/public/404.html" , status: :not_found  
        end
      end
    end
    ```

    Where 
    ● ```set_ticket``` is for basic authorization (required)
      - { username: 'example@zendesk.com', password: 'pa$$word' }
    ● ```subdomain``` is my unique identifier

  ###### Note 
    ● Request the tickets in the account, page through tickets when more than 25 are
      returned
    ● Display them in a list
  
  #### Error Handling
    ● If a user inputs a invalid ticket id an error will come up
    ● If no tickets are available
    ● If zendesk api is down
    ● If tickets exists displayed items

  #### Testing
    ● Testing the tickets controllers
    ```
      bundle exec rspec spec/controllers/tickets_controller_spec.rb
    ```

    ● Testing the features
    ```
      bundle exec rspec spec/features/tickets_spec.rb
    ```
    
  ###### Note
    ● When running 'Testing the features' for the first time it will create a recording of the external api and will place it inside spec/support.
    ● I also added a feature in VCR where it will record the status of the external api from time to time.
    ● Testing can be done offline.
    ● If VCR sees any changes to the API it will result an error and will need to be updated.

  #### Resources
    ● For testing HTTParty 
      https://github.com/jnunemaker/httparty/blob/master/spec/httparty/request_spec.rb
      - more on getting the request
    ● Zendesk
      - How the api works
      - Api endpoints
    ● Google
      - More info about capybara and rspec
    ● Youtube
      - How vcr works
    ● Stack Overflow
      - learn more about routing
      - DRYing out the code
  
  #### Challenges
    ● The zendesk api can only display 100 tickets at a time. It has different endpoints to access it. It is really a challenge figuring how to access the other endpoints. I was able to make it a bit dynamic but I have to manually type it in the browser. The links (previous and next 100 batches) are just good for covering two endpoint (200 tickets).
  
  #### Learnings
    ● Improved in uploading to github. Cautious with 'git commit -am' because it uploads everything.
    ● In github I am cautious in using 'git push origin -f' almost lost everything.
    ● Learned more about testing.
    ● Found a new gem 'vcr'

