# README

First steps to running this simple application.

* Ruby and Rails version
  - Ruby 2.5
  - Rails 5.1

* Configuration
  -Run `bundle install` right after clone the project

* Database setup
  - `rails db:creat db:migrate`

* How to run the test suite
  - To run all specs `bundle exec rspec`

* Endpoint

  ## Client
    1. Create: `post /api/v1/client`
      - Body:
      ```
      {
        "clients":[{
          "client":{
            "cnpj": string,
            "company_name": String,
            "officials_total": integer

          }
        }]
      }
      ```
      - It's possible to pass more than one client to insert in the same request

    2. Update: patch `/api/v1/client/:id`
      - Body:
      ```
      "client":{
        "cnpj": String,
        "company_name": String,
        "officials_total": integer
      }
      ```

    3. Show: get `/api/v1/client/:id`

    4. Delete: delete `/api/v1/client/:id`
      - Note that even deleted, the client still in Database for consult

    5. Show Deleted: get `/api/v1/deleted_clients`

    6. List get `/api/v1/client/`

  ## Clients Process
    1. Create post `api/vi/client_process`
      -Body:
        ```
        {
    	     "client_cnpj": String, -> Exist CNPJ in database
           "processes": [{
           	 "process":{
    			        "name": String,
    	    	      "description": String,
    	    	      "status": integer or string ->  pendente: 1, aprovado: 2, rejeitado: 3
    		          }
            }]
        }
        ```
      - It's possible to pass more than one process in the same request

    2. Update: patch `api/vi/client_process/:id`
      - Body:
        ```
        {
         "name": String,
         "description": String,
         "status": integer or string ->  pendente: 1, aprovado: 2, rejeitado: 3
         }
        ```

    3. List get `api/vi/client_process/`

    4. Delete delete `api/vi/client_process/:id`
