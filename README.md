# README

This is a sample application of what could be the basic setup for a *Social Media Lists* service. It is designed to host posts of users with multiple accounts in various social media. It also keeps compatibility with the legacy entity 'Federal Legislators', which is currently used by a number of services, as a store for Facebook/Twitter accounts of corresponding users. This application was developed, based on the idea of semanticly separating the *User* from his **n** *Social Media Accounts* of **m** different *social media types*. The new API is meant to preseve users and posts for ever, without allowing their deletion. Social media accounts though, can be added, removed, updated or just deactivated for a user. 

### Stack
* Ruby 2.2.4
* Rails 5.0.6
* PostgeSQL 10
* React.js 3.10.10

### Arcitecture
The RoR application is provided as a service to external consumers. For the time being, the only endpoint exposed, is *posts* with indexing and searching actions available. Its API is RESTful, keeping the potential of full CRUD operations for its consumers. Some of its consumers are the React.js components, used to render the list of posts. *Posts* and relatied entities are stored in a PostgrSQL database. Creation, deletion and update of any record in the *Federal Legislators* db table, triggers corresponding functions that update *users* and their *social media accounts*. Moreover, an after-save trigger of the *Social Media Account* entity in the model, triggers the appropriate updates in *Federal Legislators* db table. Therefore, the tables remain synchronized, so as we can gradually make the external dendencies of *Federal Legislators* , consume the new API.

### Database creation
[Install PostgreSQL]:http://postgresguide.com/setup/install.html
Make sure you create a role with the credentials, found in *config/database.yml*, in your PostgreSQL database.

### Deployment instructions
Just make a local copy of the folder of the application, navigate in it and open a terminal. Type:

`rake assets:precompile`

### Database initialization
Type the following:
* `rake db:create`
* `rake db:migrate`
* `rake db:migrate RAILS_ENV=test`
* `rake db:seed`
* `rake db:seed RAILS_ENV=test`

### How to run the test suite
Type:
`rspec spec`

### Services (job queues, cache servers, search engines, etc.)
* Start rails server in development environment:
`rails s`
* Visit:
`http://localhost:3000/`
to use the social media lists UI
* Perform a GET request to:
`http://localhost:3000/api/posts`
to use the API endpoint as a service consumer
* Perform a GET request to:
`http://localhost:3000/api/posts/search/a_string`
to use the API endpoint for searching amoong the posts as a service consumer

