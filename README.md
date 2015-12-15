# Sporticide
[sporticide.herokuapp.com](http://sporticide.herokuapp.com)

##Additional course related files
the presentations can be found under
> /doc/presentations

the scrum file can be found under
> /doc/scrum

##Installation
1. [Install Ruby 2.0.5 or higher](https://www.ruby-lang.org/en/documentation/installation/) if not already installed.
2. Install Bundler:

   ```ruby
   gem install bundler
   ```

3. Clone this repository.

4. Ask a [contributor](https://github.com/ASE15/Sporticide/graphs/contributors) for the ```secrets.yml```file (if you haven't already received it) and copy it to the ```/config``` directory.

5. Navigate to the root directory of the repository in terminal or a command line tool.

6. Install gems:

   ```ruby
   bundle install
   ```

7. Setup database and fill it with seeds:

  ```ruby
   rake db:migrate
   rake db:seed
   ```

8. Start rails server:

   ```ruby
   rails s
   ```

9. Navigate to ```http://localhost:3000/```with a browser.

10. Enjoy!


##General
Validations of input fields can be done using the validator.js
Doc: http://1000hz.github.io/bootstrap-validator/

### Facebook
Facebook Login is currently configured to work on heroku.

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