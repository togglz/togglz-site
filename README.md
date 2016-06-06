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
