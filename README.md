# SocialCloud ![Status completed](https://img.shields.io/badge/Status-finished-2eb3c1.svg) ![Ruby On Rails 8.1.1](https://img.shields.io/badge/RubyOnRails-8.1.1-red.svg) ![Ruby 3.3.4](https://img.shields.io/badge/Ruby-3.3.4-blue.svg) ![AngularJS 1.8.0](https://img.shields.io/badge/AngularJS-1.8.0-green.svg) ![MongoDB 4.4.23](https://img.shields.io/badge/MongoDB-4.4.23-green.svg)  ![forthebadge made-with-ruby](https://forthebadge.com/images/badges/made-with-ruby.svg) ![forthebadge made-with-javascript](https://forthebadge.com/images/badges/made-with-javascript.svg)
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

- Ruby on Rails 8.1.1
- Ruby 3.3.4
- AngularJS - 1.8.0 ( Javascript Framework )
- SQLLite / PostgreSQL / MongoDB (v4.4.23)
- Bootstrap ( HTML / CSS / Javascript )

----------------------------
INSTRUCTIONS TO RUN THE PROJECT
----------------------------

Type the following commands in sequential order:
```
bundle install     (To install all gems)
rails s            (To start the server)
```

For testing:
```
bundle exec rspec spec (From root directory)
```

For starting the rails console:
```
rails c
```

For creating db:
```
1. db:create
2. db:migrate
The above commands create and apply the tables for User class.
For MongoDB (Post Class), the db is created on the go.
```

For deleting db:
```
1. db:drop [1. Deletes users, stored in SQL DB]
2. mongo
3. use social_cloud_development
4. db.dropDatabase() [2., 3., 4. delete posts, stored in MongoDB] 
OR
rails c
- User.delete_all
- Post.delete_all
```       

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
- email: user1@gmail.com username: user1 password: password
- email: user2@gmail.com username: user2 password: password
- email: user3@gmail.com username: user3 password: password

----------------
NOTE
-----------------

MongoDB needs to be installed on machine and configured using mongoid.
Refer to mongoid.yml inside config folder and mongoid documentation for further details.

Ruby (preferably via rvm - ruby version manager) and Rails also need to be installed 
on the system.
--------------
