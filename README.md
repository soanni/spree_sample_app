## Engine Yard's Spree Sample Application

[Spree](https://github.com/spree/spree) is a complete open source ecommerce solution for Ruby on Rails.
It comes in the form of a Rails Engine and must created inside a host application.
This repository contains a Spree host application with some additional tools to help you deploy on Engine Yard.
After reviewing this, you should create your own spree application or fork this one and make the appropriate customizations.

**Engine Yard won't update Spree versions that often, so you shouldn't expect to pull updates from this repository.
We may address eventual security risk issues and enhance the deployment workflow.**

#### Setting up the application

* Go to your account panel and create an application
* Use `git@github.com:engineyard/spree_sample_app.git` for **Git Repository URI**
* Give you application a name. We'll use **spree** for this guide
* Choose **Rails 5** for **Web Application Framework**

#### Setting up the environment
* Choose **Puma** as your **Application Server Stack** (*)
* Use a **stable-v5** Stack
* Use **Ruby 2.3** as **Runtime**
* Choose **MySQL 5.6** as your **Database Stack** (**)

(*) Is you don't find Puma in the application server list, refer to this [link](https://support.cloud.engineyard.com/hc/en-us/articles/205413928-Use-Puma-with-Engine-Yard-Cloud).

(**) Spree supports any database ActiveRecord does. We recommend MySQL specifically for this guide because our sample data loading procedure uses `mysqldump` and restore commands. Our sample data is considerably larger than the default one which is better representative of a live ecommerce website. That way you can make an educated decision after appraising performance.

#### Booting a cluster

Now you have a chance to define the cluster configuration for this environment.
Go ahead and choose a **production** cluster to take advantage of load balancing and redundancy for the app and database instances.
After this, feel free to experiment with different options Engine Yard recommends or spin up your own.

#### Important steps before deployment

##### Secrets.yml

Rails 5 makes use of a `secrets.yml` file to define a variable that verifies the integrity of signed cookies.
That file shouldn't be kept in the repository and Engine Yard offers a custom chef recipe to help you with that.

[Download](https://github.com/engineyard/spree_sample_app/archive/master.zip) or [clone](https://github.com/engineyard/spree_sample_app) this repo, so you can upload your own secrets file to EngineYard.

There's a `cookbooks` folder in the root of this application. Locate `custom-rails_secrets/recipes/templates/default`
and add a file named `secrets.yml.{name_of_your_app}.erb`(eg: secrets.yml.spree.erb). This file will be ignored
by `.gitignore`, so you don't have to worry committing by mistake. Go ahead and copy `example.yml` and replace the base_key
with the output of `rails secret` command.

Now let Engine Yard know about that custom Chef Recipe. After installing the [engineyard gem](https://github.com/engineyard/engineyard) go to the root of this repo and run:

```
ey recipes upload --environment name_of_your_environment
```

Go to your environment's page and click Apply.

##### Shared File System

When creating products on Spree you will have to upload images to the server's file system.
As you might have guessed in a multi server configuration all of your instances have to access the images folder.
As your provisioning goes on, take this time to create a Shared File System as one of your environment options.
The deployment process will take care of linking all of your instances to that mount point.

#### Using Spree

This installation will create an admin user with the following credentials. You may access the admin panel on `http://{host}/admin`
* email: spree@engineyard.com
* password: engineyard


#### Deploying outside of Engine Yard

If you want to deploy this sample app outside of Engine Yard you can follow the steps described in the [official guide](http://guides.spreecommerce.org/developer/manual-ubuntu.html).

**Skip the default step for Loading Seed Data**

After the installation, ssh into your box and run the following command to Load our Custom Seed Data:

```
bundle exec rake db:load_sample_if_empty_db
```