!SLIDE

# Packaging and Dependencies #

!SLIDE

# RubyGems #

!SLIDE

# More than 20k Published Gems #

!SLIDE commandline

    gem install httparty
    When you HTTParty, you must party hard!
    Successfully installed httparty-0.7.4
    1 gem installed
    

!SLIDE smaller

    @@@ruby
    require 'rubygems'
    require 'httparty'
    url = 'http://twitter.com/statuses/public_timeline.json'
    HTTParty.get(url).each do |item|
      p "#{item['text']} by @#{item['user']['screen_name']}" 
    end; nil

!SLIDE

# Bundler #

!SLIDE

    @@@ruby
    # Gemfile
    source :rubygems
    gem 'httparty'

!SLIDE commandline 

    bundle install
    Fetching source index for http://rubygems.org/
    Using crack (0.1.8) 
    Using httparty (0.7.4) 
    Using bundler (1.0.10) 
    Your bundle is complete! Use `bundle show [gemname]` 
    to see where a bundled gem is installed.

!SLIDE

# RVM #

!SLIDE code

    rvm use ruby-1.9.2
    rvm gemset create myapp
    rvm gemset use myapp

!SLIDE

# .rvmrc #

!SLIDE
    
    rvm use ruby-1.9.2
    rvm gemset use myapp

    $ cd ../myapp
    Using /Users/aeden/.rvm/gems/ruby-1.9.2-p0
    Now using gemset 'myapp'    
