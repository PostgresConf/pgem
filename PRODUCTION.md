Running OSEM in Production mode
-------------------------------

**install rvm**

    gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
    curl -sSL https://get.rvm.io | bash

**install the Ruby 2.1 and create a gemset for the app**

    rvm install 2.1
    rvm gemset create osem
    rvm use ruby-2.1.10@osem --default

**install some prerequisites**

    sudo apt install nodejs imagemagick libmagickcore-dev libmagickwand-dev


**install Ruby Bundler**

    gem install bundler

get the code into some writable directory (referred as APPDIR below)

**database setup**
create the pg user and database for the app
edit the database.yml file in APPDIR/config and put the db name and credentials in the production: section
either run

    RAILS_ENV=production bundle exec rake db:migrate 

(for fresh installs) OR just restore the DB from the dump

**install the app gems**

    cd APPDIR
    bundle install

**configure the** app
OSEM is a regular Rails application, so the common practices apply, one specific thing however is the it uses .dotenv files for sensitive configuration directives, so you should create the APPDIR/.env.production file (use the dotenv.example as a reference), SMTP settgins are also configured here.
Add SECRET_KEY_BASE definition to the ENV file like so:

> SECRET_KEY_BASE='f4be765bc98e516de82ac01daa8f8aa11c5ca13cb6c911887851ac89457b6c0b056b2361a21b5c08926c9386e0f91eef84fc0b103d522bf00bc0c78ea8ce7c58'

**NOTE**: it is important to use the unique secret for each installation, to generate new secret just run:

    bundle exec rake secret
   in the APPDIR

**configure the apache/nginx + mod_passenger** (I will be covering the Apache case here)
    1. Edit the passenger.conf file under the /etc/apach2/mods-enabled dir, adjust the to the path of the RVM installed ruby wrapperlike so: PassengerDefaultRuby /home/cmd/.rvm/wrappers/ruby-2.1.10@osem/ruby
    2 .Configure the virtualhost for the app, point the the DocumentRoot to the APPDIR/public
    3. Reload the apache configuration

**NOTE**: you may want to temporarily enable verbose passenger diagnostics output by adding the PassengerFriendlyErrorPages on to the apache VirtualHost configuration, here is a full virtual host configuration taked from the live server

    <VirtualHost *:80>
        ServerAdmin eugend@commandprompt.com

        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined
        DocumentRoot /home/cmd/osem-pg/public
        PassengerFriendlyErrorPages on
        <Directory /home/cmd/osem-pg/public>
                Require all granted
                AllowOverride all
                Options -MultiViews
        </Directory>
    </VirtualHost>

**Precompile the application assets** (passenger usually does that, but do this just in case)

    RAILS_ENV=production bundle exec rake assets precompile

from now the HTTP requests to your virtualhost should be routed to mod passenger

Reloading the app:

    touch APPDIR/tmp/restart.txt



