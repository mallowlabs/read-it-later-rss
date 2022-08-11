Read It Later RSS
====================================
Pocket (Read It Later) RSS Generator.

URL
---------------
https://read-it-later-rss.herokuapp.com

Deploy commands
---------------

Heroku Setup

    $ heroku create
    $ heroku addons:add heroku-postgresql
    $ heroku addons:add scheduler
    $ git push heroku master
    $ heroku bundle exec rake db:migrate

Cron Test

    $ heroku bundle exec rake cron

Cron Log

    $ heroku logs:cron

Author
---------------

* @mallowlabs

