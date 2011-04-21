## Introduction

We are a product of our experiences. Increasingly, we deposit digital traces
of those experiences around the web (e.g., Twitter, Gowalla, GitHub, Last.fm,
etc.) and on our various computing devices. Together, these deposits form a
rich archeological history. Stratify gathers (excavates, if you will) that
data from those disparate sources and provides a consolidated timeline of
your experiences.

Stratify allows you to configure *collectors* for the data sources from which
you want to pull in your activities.  Stratify currently provides collectors
for:

* [Twitter](http://twitter.com)
* [Gowalla](http://gowalla.com)
* [Instapaper](http://instapaper.com)
* [Rhapsody](http://rhapsody.com)
* iTunes

Once you've decided which collectors you want to use, Stratify goes to work
building a consolidated history for you. And then, when you add a new tweet
or check in at your favorite coffee shop (for example), Stratify sees those
new activities and automatically adds them to your history.

Stratify is a Rails app, but most of the core logic (i.e., all of the data
collection logic) is just Ruby. Stratify uses Rails to provide the (currently
very vanilla) UI for displaying the activity timeline. I hope to eventually
provide a more rich user interface experience.

[![Stratify Screenshot](https://img.skitch.com/20110417-fkjd9gse8ubsjbnc51ganks1y3.medium.jpg)](https://skitch.com/jasonrudolph/r4155/stratify "Stratify Screenshot")


## Open source, but not an "open source project"

"I am sharing my code. I am not launching an open source project." -- Alan Gutierrez

[http://kiloblog.com/post/sharing-code-for-what-its-worth](http://kiloblog.com/post/sharing-code-for-what-its-worth "GitHub and Git: Sharing Your Code, for What It&#8217;s Worth ...")


## Dependencies

Stratify is developed and tested with the following dependencies.

* Ruby 1.9.2
* MongoDB 1.8


## Getting started

To use Stratify, clone the repo, `cd` into the root directory, and ...

    gem install bundler
    bundle
    cp config/mongoid.example.yml config/mongoid.yml
    rails server -e production

Now that you have the Rails app running, it's time to configure some collectors.


## Configuring and running collectors

### Configure

The collectors run via a Rake task (conveniently named `collectors:run`).  To set up your desired collectors, first make a copy of the [example rake task](https://github.com/jasonrudolph/stratify/blob/master/lib/tasks/collectors.example.rake).

    cp lib/tasks/collectors.example.rake lib/tasks/collectors.rake

Then, open `lib/tasks/collectors.rake` in your favorite editor and configure your desired collectors.

### Test

Once you've updated `collectors.rake`, you're ready to start pulling data into your timeline.

    `RAILS_ENV=production rake collectors:run`

After the rake task completes, head back to the UI, and you should see your latest activities in your timeline.

### Automate

Now you're ready to set up your collectors to run automatically.  Stratify runs the collectors via cron using the [whenever](http://github.com/javan/whenever) gem.  By default, the cron job will execute the `collectors:run` task every two hours.  You can change these settings in `config/schedule.rb`.

To install the cron job ...

    # cd to the Stratify root directory and ...
    whenever --update-crontab
    crontab -l # show updated crontab


## Sample data

TODO - Add easy mechanism for loading example data


## TODO

* UI for users to configure collectors
* Rake task for loading sample data (currently handled via db/samples.rb)
* More collectors (e.g., GitHub, Garmin, etc.)
* UI design
* Better error notification in collectors
* Plugin model for collectors (including extracting existing collectors into plugins)
* Ability to search for activities
* Statistical analysis (e.g., trends)


## Developers, developers, developers, ...

If you find yourself hacking on Stratify, get your TDD on with Spork an Watchr.  [Spork rocks](http://chrismdp.github.com/2010/11/getting-spork-working-now-on-rails-3-rspec-2-and-cucumber/).  Watchr rocks.  Behold!

Open a terminal window and start a Spork instance for RSpec and Cucumber:

    # The RSpec and Cucumber versions of spork use different ports, 
    # so there’s no problem running them together. Just run one as a
    # background process.
    bundle exec spork cucumber & bundle exec spork

Open a second terminal window and fire up Watchr:

    bundle exec watchr specs.watchr
    
Enjoy sweet, speedy BDD/TDD bliss.


## License

Copyright 2011 Jason Rudolph ([jasonrudolph.com](http://jasonrudolph.com)). Released under the MIT license. See the LICENSE file for further details.
