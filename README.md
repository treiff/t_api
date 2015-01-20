# Twitter-Stats

Sinatra app built to explore data-mining using the Twitter API.

## Features
So far features are expanding.  The primary reason for building the app was as a learning experience.  I will gradually improve the features as time permits.

* Charts of Twitters users:
  * tweets broken down by day of week.
  * tweets broken down by time of day.
  * followers trend graph.
* Location based queries:
  * Search by term, location, radius and return tweets that match
  
## Dependencies

* Twitter API
* Twittercounter API
  * Gems
 'sinatra'
 'twitter'
 'chartkick'
 'geocoder'
 'groupdate'
 'httparty'

  
## Todo

* Add validation to forms.
* Error handling.
* Finish styling (very rough for now)
* Add more functions for different data interpretation.

## Installation

If you want to mess around with it locally, you can clone it then run:


    $ bundle install
    
To get the server up and running, run:

    $ rackup