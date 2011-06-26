## About This Plugin

Because stratify-rails is a subfolder inside the stratify repo, that creates
a challenge for deploying with Capistrano. Capistrano expects your Rails app
to sit at the root of your repo. We could certainly split the Rails app out
into a separate repo, but that introduces additional management overhead. At
the moment, that additional overhead does not have enough benefits to justify
taking it on.

## Credits

This plugin is courtesy of @RicSwirrl.  Read about it here:

http://ricroberts.com/articles/deploying-a-sub-folder-with-capistrano
