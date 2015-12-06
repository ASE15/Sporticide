# Sporticide
CyberCoach App

##Additional course related files
the presentations can be found under
> \presentations

the scrum file can be found under
> \scrum

##Installation
###Prerequirements
a working installation of Ruby on Rails

###Installation
Download the latest version directly from GitHub or clone into the project.

Install the necessary gems
> bundle install

Update your database
> rake db:migrate

Run the app
> rails server

The application can then be accessed with any browser on
> http://localhost:3000/

##General
Validations of inpot flields can be done using the validator.js
Doc: http://1000hz.github.io/bootstrap-validator/

### Facebook
Facebook Login is currently configured to work on localhost:3000, so 
it won't work on heroku currently.

### Templates
To set the big and small title in the new template, include following code in a specific template:

```<% content_for :title do %>
   <h1>
      Title
      <small>small title</small>
  </h1>
<% end %>
```

### User name
If you want to display the users full name if available, you the method
> user_model.get_name

This prints either the uername, if no first & last name is available, other else it begins with returning the first name and perhaps concatenated with the last.