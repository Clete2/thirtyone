[![Build Status](https://travis-ci.org/matthew6project/thirtyone.svg?branch=master)](https://travis-ci.org/matthew6project/thirtyone)

Matthew 6:31
=====================
<i>Therefore do not be anxious, saying, 'What shall we eat?' or 'What shall we drink?' or 'What shall we wear?'</i>

Objective
---------------------
ThirtyOne is a Matthew6 project with the goal of providing an application that can be used to collect and maintain an inventory of goods and manage the distrbution of those goods to those in need.  The initial focus of this project is on food pantries and making day to day operations run more smoothly while also offering many nice tracking and customer management features.

This project is currently in the initial requirements gathering and design phase.  Once we begin coding we will post more information on how to use our product and how to get involved and contribute.

Development
---------------------
To setup your development environment after cloning the repo run:
```
bundle install
rake db:migrate
rake db:seed
rails server
```

You can now navigate to `localhost:3000` on your workstation and begin demoing the code

The default username and password is `admin` `admin`
