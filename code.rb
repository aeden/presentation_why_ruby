# obligatory hello world 
p "hello, world"

# string interpolation
name = 'Anthony'
p "hello, #{name}"

# everything is an object
# objects have methods
2.even?                     # returns true
1.2.ciel                    # returns 2
"Anthony knows Ruby".length # returns 18

# method names
word = "   example  "

word.strip    # returns "example"
p word        # prints "   example  "
word.strip!   # returns "example"
p word        # prints "example"

File.readable? '/etc/password'
File.readable? '/tmp'

# methods can be chained
# returns ['Ruby', 'knows', 'Anthony']
"Anthony knows Ruby".split.reverse

# methods can accept blocks
[1, 2, 3, 4].map { |i| i ** 2 } # [1, 4, 9, 16] 
5.times { p 'ohai' }    # prints "ohai" 5 times
0.upto(5) { |n| p n }   # prints from 0 to 5
(0..5).each { |n| p n } # also prints from 0 to 5

# defining a class
class Person
end

# constructing an instance
person = Person.new

# initializer, instance variables, methods
class Person
  def initialize(name)
    @name = name
  end
  def name
    @name
  end
end

person = Person.new('Anthony')
person.name

# attr_reader
class Person
  attr_reader :name
  def initialize(name)
    @name = name
  end
end

person = Person.new('Anthony')
person.name

# multiple attr_reader
class Person
  attr_reader :name
  attr_reader :height
  def initialize(name)
    @name = name
  end
end

person = Person.new('Anthony')
person.name     # returns 'Anthony'
person.height   # returns nil

# initialize with hash, attr_reader on one line
class Person
  attr_reader :name, :age, :height

  def initialize(attrs={})
    @name = attrs[:name]
    @age = attrs[:age]
    @height = attrs[:height]
  end
end

person = Person.new(:name => 'Anthony', :height => 180)
person.name     # returns 'Anthony'
person.height   # returns 180
person.age      # returns nil

# attr_accessor
class Person
  attr_accessor :name, :age, :height

  def initialize(attrs={})
    @name = attrs[:name]
    @age = attrs[:age]
    @height = attrs[:height]
  end
end

person = Person.new(:name => 'Anthony', :height => 180)
person.age = 34
person.age      # returns 34

# set variable values on one line, idiomatic methods
class Person
  attr_accessor :name, :age, :height

  def initialize(attrs={})
    @name, @age, @height = attrs[:name], 
      attrs[:age], attrs[:height]
  end

  def height_in_inches
    height * 0.39370079
  end
end

person = Person.new(:height => 180)
person.height_in_inches # returns 70.8661422

# constants
class Person
  attr_accessor :name, :age, :height

  def initialize(attrs={})
    @name, @age, @height = attrs[:name], 
      attrs[:age], attrs[:height]
  end

  CM_TO_INCHES = 0.39370079
  def height_in_inches
    height * CM_TO_INCHES
  end
end

person = Person.new(:height => 180)
person.height_in_inches # returns 70.8661422

# class methods
class Person
  @people = {}
  def initialize(name)
    @name = name
  end
  def self.find_or_create(name)
    @people[name] ||= Person.new(name)
  end
end
Person.find_or_create('Anthony')
Person.find_or_create('John')
Person.find_or_create('Anthony') # same object as before



# each and send
class Person
  attr_accessor :name, :age, :height

  def initialize(attributes={})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
end

person = Person.new(:name => 'Anthony')
person.name

# sidebar: each
people = ['John', 'Jane', 'Jim']
for person in people
  p person
end
people.each do |person|
  p person
end
people.each { |person| p person }

# with a method that does not exist an error is raised
person = Person.new(:eye_color => :green)

# respond_to? to check existence of method
class Person
  attr_accessor :name, :age, :height

  def initialize(attributes={})
    attributes.each do |name, value|
      send("#{name}=", value) if respond_to?("#{name}=")
    end
  end
end

person = Person.new(:eye_color => :green)

# instance_eval to add a method to a class
class Person
  def initialize(attributes={})
    attributes.each do |name, value|
      if respond_to?("#{name}=")
        send("#{name}=", value)
      else
        Person.instance_eval do
          attr_accessor name
        end
        send("#{name}=", value)
      end
    end
  end
end

person = Person.new(:eye_color => :green)
person.eye_color

# refactoring with unless
class Person
  def initialize(attributes={})
    attributes.each do |name, value|
      unless respond_to?("#{name}=")
        Person.instance_eval do
          attr_accessor name
        end
      end
      send("#{name}=", value)
    end
  end
end

person = Person.new(:eye_color => :green)
person.eye_color

# refactoring into private methods
class Person
  def initialize(attributes={})
    attributes.each do |name, value|
      set_attribute(name, value)
    end
  end

  def set_attribute(name, value)
    unless respond_to?("#{name}=")
      Person.instance_eval do
        attr_accessor name
      end
    end
    send("#{name}=", value)
  end
  private :set_attribute
end

person = Person.new(:name => 'Anthony')
person.name
person.set_attribute('sex', 'male')

# inheritence
class Employee < Person
  attr_accessor :number
end
person = Employee.new(:name => 'Anthony')
person.number = 1000

person = Person.new(:name => 'Anthony')
person.number = 1000

# modules for functionality
module Employable
  attr_accessor :number
end
class Person
  include Employable
end
person = Person.new(:name => 'Anthony')
person.number = 1000


# modules for namespacing
module AddressBook
  class Person
  end
end
person = AddressBook::Person.new

# OR-equal operator, append operator, extending an instance with a module
module Manageable
  def tasks
    @tasks ||= []
  end
  def assign_task(task)
    tasks << task
  end
end
# this will work
person = Person.new(:name => 'Anthony')
person.extend(Manageable)
person.assign_task('Make me a sandwich')

# this will raise an error
ceo = Person.new(:name => 'John')
ceo.assign_task('Make me a sandwich')

# speaking of raising errors
class Person
  def do_something
    raise "I refuse to do it"
  end
end
person = Person.new
person.do_something

# rescue from an error
begin
  person.do_something
rescue => e
  "the person didn't do what we asked: #{e}"
end

# rescue from an error as part of a method block
class Person
  def catch_an_error
    raise "an error"
  rescue => e
    "an error was raised"
  end
end
person = Person.new
person.catch_an_error

# ensure
f = File.open('/etc/resolv.conf')
begin
  p f.read
rescue => e
  puts "error: #{e}"
ensure
  f.close if f
end

# even better
begin
  File.open('/etc/resolv.conf') do |f|
    p f.read
  end
rescue => e
  puts "error: #{e}"
end

# RubyGems
# gem install httparty
require 'rubygems'
require 'httparty'
url = 'http://twitter.com/statuses/public_timeline.json'
HTTParty.get(url).each do |item|
  p "#{item['text']} by @#{item['user']['screen_name']}" 
end; nil

# Bundler
source :rubygems
gem 'httparty'
# gem install bundler
# bundle install

# Test::Unit
class Person
  attr_reader :height
  def intialize(height)
    @height = height
  end
  def height_in_inches
    height * 0.39370079
  end
end

require 'test/unit'
class PersonTest < Test::Unit::TestCase
  def test_height_in_inches
    person = Person.new(180)
    assert_equal person.height_in_inches, 0
  end
end
