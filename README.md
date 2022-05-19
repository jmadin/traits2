# Trait database quick-start guide

The following quick start guide creates a development database (using sqlite3).  The assumption is that you are trying out the database, and so don't need to get fancy at this stage. The first step is to set up rails on you computer or server (if you haven't already). A rails installation guide can be found here: [http://installrails.com](http://installrails.com)

The below quick start guide was last updated for ruby-2.2.3.

1. Clone the github repository

        git clone https://github.com/jmadin/traits2.git

2. Move into the traits directory

        cd traits2

3. Make sqlite3 database configuration file and local environment file  

        cd config  
        cp database.yml.sqlite database.yml  
        cp local_env.yml.example local_env.yml  

4. Return to base directory and install gems (see Notes 1)

        cd ..
        bundle install

5. Migrate database structure to sqlite3 development database and seed with example data

        rake db:migrate
        rake db:seed

6. Start solr search (see Notes 2)

        rake sunspot:solr:start
        rake sunspot:solr:reindex

7. Start rails server

        rails s

8. Log-in at ([http://localhost:3000/signin](http://localhost:3000/signin))

        admin@traits.org
        foobar

9. Change password at ([http://localhost:3000/users/1/edit](http://localhost:3000/users/1/edit))

### Notes


1. The bundler will complain if you don't have postgres installed. Postgres is used for production, but you don't have to have it installed when developing on local machine, which uses

https://wiki.postgresql.org/wiki/Homebrew



2. On a Mac, you need to have JDK 8 installed. Easiest to do with `brew`

        brew install adoptopenjdk/openjdk/adoptopenjdk8
        java -version
