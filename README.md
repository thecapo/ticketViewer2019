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
    
    ● Go to that directory
    ● Once inside the folder, run the app by typing 
      ```
      $ rails s
      ```

    ● When the app is running enter 
      ```
      $ localhost:3000
      ```
  ##### Note
    ● There won't be any tickets in there.
  
  #### Usage
    ● Once done installing the app and assuming it is running on localhost, you can access tickets from Zendesk account.
      ● If you have no account you can create it here [Zendesk Account](https://www.zendesk.com/register/#getstarted).

    ● Populating your account with dummy data if you have none.
      ● Copy dummy data here or download it as zip. Click this link [tickets.json](https://gist.github.com/svizzari/c7ffed8e10d3a456b40ac9d18f34289c)
      ● Create a ticket.json or put the tickets.json file if downloaded inside the app folder. 
      ● By using curl enter this in the terminal. Make sure the tickets.json is in that folder.

        ```
        $ curl https://{subdomain}.zendesk.com/api/v2/imports/tickets/create_many.json -v -u {email_address}/token:{token_holder} -X POST -d @tickets.json -H "Content-Type: application/json"
        ```

        Please note that you have to activate you api by going to settings > channels > api then enable token. You will then receive a token to place inside the ```token_holder```
    ● Gems used

        Fetching data
      ```
        HTTParty 
      ```

        Pagination
      ```
        will_paginate
      ```

        Testing 
      ```
        rspec
        vcr
        webmock 
      ```


    ```ruby
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
    ● ```subdomain``` is your unique identifier

  ###### Note 
    ● Request the tickets for your account, page through tickets when more than 25 are
      returned
    ● Display them in a list
    ● Display individual ticket details

  #### Error Handling
    ● If a user inputs a invalid ticket id an error will come up
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
    ● Once the testing features is compiled it will create recording of the external api.
    ● Testing can be done offline.
    ● Any changes to the testing will result an error and will need to be updated.

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
      - DRY out the code
  
  #### Challenges
    ● The zendesk api can only display 100 tickets at a time. It has different endpoint to access it. It is really a challenge figuring how to access the other endpoint. I was able to make it a bit dynamic but I have to manually type it in the browser. The links are just good for two endpoint (200 tickets)
  
  #### Learnings
    ● Improved in uploading to github. Does not do 'git commit -am' because it uploads everything.
    ● In github I am cautious in using 'git push origin -f' almost lost everything.
    ● Learned more about testing.
    ● Found a new gem 'vcr'

