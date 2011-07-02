## Introduction

We are a product of our experiences. Increasingly, we deposit digital traces
of those experiences around the web (e.g., Twitter, Gowalla, GitHub, Last.fm,
etc.) and on our various computing devices. Together, these deposits form a
rich archeological history. Stratify gathers (excavates, if you will) that
data from those disparate sources and provides a consolidated timeline of
your experiences.

Stratify allows you to configure *collectors* for the data sources from which
you want to pull in your activities.  Stratify currently provides collectors
for Twitter, Gowalla, iTunes, and other sources as well.

Once you've decided which collectors you want to use, Stratify goes to work
building a consolidated history for you. And then, when you add a new tweet
or check in at your favorite coffee shop (for example), Stratify sees those
new activities and automatically adds them to your history.

Stratify is a Rails app, but most of the core logic (i.e., all of the data
collection logic) is just Ruby. Stratify uses Rails to provide the (currently
very simple) UI for displaying the activity timeline. I hope to eventually
provide a more rich user interface experience.

### Screenshots

#### Activity Timeline

[![Stratify Activity Timeline  Screenshot](https://img.skitch.com/20110509-tjkykqb8w25gf1bngm4mee17k5.medium.jpg)](https://skitch.com/jasonrudolph/r6efc/stratify "Stratify Activity Timeline Screenshot")

#### Punch Card Graph

This data practically begs for visualization.  Stratify currently provides a "punch card" graph for each of your activity sources. In the screenshot below, the Instapaper activity reveals a clear pattern: apparently I do most of my Instapaper reading at night and on weekend mornings. (This graph is generated from real data. And yeah, that pattern sounds about right.)

This data is ripe with opportunities for rich visualization.  (Thanks to GitHub for [the idea for this particular graph](https://github.com/jasonrudolph/stratify/graphs/punch_card).)

[![Stratify Punch Card Graph Screenshot](https://img.skitch.com/20110702-jmu63tjdtd3628rs1wuc8i8mh5.medium.jpg)](https://skitch.com/jasonrudolph/r6efc/stratify "Stratify Punch Card Graph Screenshot")

## Components

Stratify consists of the following parts:

* **stratify-base**: Core collector and activity componentry.
* **stratify-rails**: Rails app for configuring collectors and displaying collected activities.
* **stratify-gowalla**: Collects your checkins from Gowalla.
* **stratify-instapaper**: Collects the articles you've archived on Instapaper.
* **stratify-itunes**: Collects the songs you've listened to, shows you've watched, and so on, from iTunes.
* **stratify-rhapsody**: Collects the songs you've played on Rhapsody.
* **stratify-twitter**: Collects your tweets.


## Dependencies

Stratify is developed and tested with the following dependencies.

* Ruby 1.9.2
* MongoDB 1.8


## Getting started

To use Stratify, clone the repo, and ...

    cd stratify/stratify-rails
    gem install bundler
    bundle
    cp config/mongoid.example.yml config/mongoid.yml
    rails server -e production

Now that you have the Rails app running, it's time to configure some collectors.


## Configuring and running collectors

### Configure

To set up your desired collectors, pop open the UI and follow the yellow brick road.  Add your desired collectors, run them, and then you'll start seeing data show up in your timeline.

### Automate

Running the collectors via the UI is useful for making sure that you've got them configured correctly.  But once you've verified that they're working, you'll want to set up your collectors to automatically run on a regular basis.

Stratify provides a Rake task for running all your collectors at once.  It's conveniently named `collectors:run`.  

To provide the automation we're looking for, Stratify runs the collectors via cron using the [whenever](http://github.com/javan/whenever) gem.  By default, the cron job will execute the `collectors:run` task every two hours.  You can change these settings in `config/schedule.rb`.

To install the cron job ...

    # cd to the stratify-rails directory and ...
    whenever --update-crontab
    crontab -l # show updated crontab


## Sample data

TODO - Add easy mechanism for loading example data


## TODO

* Rake task for loading sample data (currently handled via db/samples.rb)
* More collectors (e.g., GitHub, Garmin, etc.)
* UI design
* Better error notification in collectors
* Ability to search for activities
* Additional statistical analysis (e.g., trends)


## Contributors

Thanks to [Jared Pace](http://github.com/jdpace) and [Michael Parenteau](http://github.com/michaelparenteau) for their contributions.

## License

Copyright 2011 Jason Rudolph ([jasonrudolph.com](http://jasonrudolph.com)). Released under the MIT license. See the LICENSE file for further details.
