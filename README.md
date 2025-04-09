# SocialCloud ![Status completed](https://img.shields.io/badge/Status-finished-2eb3c1.svg) ![Ruby On Rails 5.0.7.2](https://img.shields.io/badge/RubyOnRails-5.0.7.2-red.svg) ![Ruby 2.5.1](https://img.shields.io/badge/Ruby-2.5.1-blue.svg) ![AngularJS 1.6.8](https://img.shields.io/badge/AngularJS-1.6.8-green.svg)  ![forthebadge made-with-ruby](https://forthebadge.com/images/badges/made-with-ruby.svg) ![forthebadge made-with-javascript](https://forthebadge.com/images/badges/made-with-javascript.svg)
----------------------------
ABOUT THE PROJECT
----------------------------

This project provides the features of a social networking site
with features involving posting images with captions and headings,
following others, searching for other users, user authentication and
authorization, editing profile, signing up etc. online. It basically
resembles Instagram. This project is implemented using Ruby on Rails
Framework (Ruby), AngularJS, Javascript, HTML(Bootstrap), CSS,
Heroku, MongoDB and MongoDB Atlas.

----------------------------
TECHNOLOGIES USED
----------------------------

- Ruby on Rails 7.1.5.1
- Ruby 3.3.0
- AngularJS - 1.6.8 ( Javascript Framework )
- SQLLite / PostgreSQL / MongoDB (v3.6.3)
- Bootstrap ( HTML / CSS / Javascript )

----------------------------
INSTRUCTIONS TO RUN THE PROJECT
----------------------------

Type the following commands in sequential order:

              bundle update      (To update all gems)
              bundle install     (To install all gems)
              rails s

For testing:

              bundle exec rspec spec (From root directory)               

----------------------------
# Main Components of Application
--------------

App folder contains the main application logical component.
- In assets folder all the javascript, manifest of javascript and bootstrap etc can be found
alongwith the angularJS module and other declarations.
- In controllers folder all the controllers regarding posts, users, welcome(root page), etc can be found.
- In models folder all the structure of user and post class can be found.
- In views folder all the html can be found alongwith layouts, etc.

Config folder contains all the configuartion specific files and details.

Db folder contains all the migrations, test database (partial), schema of database etc.

Spec folder contains the application testing component.

Following are the users for the application(master branch - development mode):

- email: shashwat@gmail.com username: shashwatkathuria password: shashwat
- email: cristiano@gmail.com username: cristiano password: ronaldo
- email: akshay@gmail.com username: akshaygupta password: akshay
- email: john@gmail.com username: johncena password: johncena

----------------
NOTE
-----------------

MongoDB needs to be installed on machine and configured using mongoid.
Refer to mongoid.yml inside config folder and mongoid documentation for further details.

--------------
