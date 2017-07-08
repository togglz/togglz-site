# Togglz Site

The is repository contains the full source of the [togglz.org](http://www.togglz.org/) site.

## Building the site

You will need to install Ruby 2.2.5 or newer and a few gems:

    $ gem install awestruct bootstrap-sass haml-contrib maruku

To start the development mode execute this command:

    $ awestruct -d

After a few seconds you can open [http://localhost:4242/](http://localhost:4242/) in
your browser to preview the site. Now you can start to edit the source files. Changes
will automatically be compiled.

## Using Docker

Create an container

    $ docker run -it --name togglz-site -v $(pwd):/opt/togglz-site -p 4242:4242 ruby:2.4.1 bash

Install the required dependencies

    $ gem install awestruct bootstrap-sass haml-contrib maruku

Run the dev mode:

    $ cd /opt/togglz-size
    $ awestruct -b 0.0.0.0 -d
