!SLIDE

# Basics #

!SLIDE

    @@@ruby
    # obligatory hello world 
    p "hello, world"

!SLIDE commandline

    ruby -e 'p "hello, world"'

!SLIDE

    @@@ruby
    name = 'Anthony'
    p "hello, #{name}"

!SLIDE

    @@@ruby
    # everything is an object
    # and objects have methods
    2.even?                     # returns true
    1.2.ceil                    # returns 2
    "Anthony knows Ruby".length # returns 18

!SLIDE

    @@@ruby
    # method names
    word = "   example  "

    word.strip    # returns "example"
    p word        # prints "   example  "
    word.strip!   # returns "example"
    p word        # prints "example"

    File.readable? '/etc/password'
    File.readable? '/tmp'

!SLIDE

    @@@ruby
    # methods can be chained
    # returns ['Ruby', 'knows', 'Anthony']
    "Anthony knows Ruby".split.reverse

!SLIDE smaller

    @@@ruby
    # blocks
    [1, 2, 3, 4].map { |i| i ** 2 } # [1, 4, 9, 16]
    
    5.times { p 'ohai' }    # prints "ohai" 5 times
    
    0.upto(5) { |n| p n }   # prints from 0 to 5
    
    (0..5).each { |n| p n } # also prints from 0 to 5

!SLIDE

#Classes and Objects#

!SLIDE

    @@@ ruby
    # defining a class
    class Person
    end

    # constructing an instance
    person = Person.new

!SLIDE

    @@@ruby
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
    
!SLIDE

    @@@ruby
    # attr_reader
    class Person
      attr_reader :name
      def initialize(name)
        @name = name
      end
    end

    person = Person.new('Anthony')
    person.name

!SLIDE

    @@@ruby
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

!SLIDE

    @@@ruby
    # initialize with hash
    class Person
      attr_reader :name, :age, :height

      def initialize(attrs={})
        @name = attrs[:name]
        @age = attrs[:age]
        @height = attrs[:height]
      end
    end

    person = Person.new(
      :name => 'Anthony', 
      :height => 180
    )
    person.name       # returns 'Anthony'
    person.height     # returns 180
    person.age        # returns nil
    person.age = 34   # raises an error

!SLIDE

    @@@ruby
    # attr_accessor
    class Person
      attr_accessor :name, :age, :height

      def initialize(attrs={})
        @name = attrs[:name]
        @age = attrs[:age]
        @height = attrs[:height]
      end
    end

    person = Person.new(
      :name => 'Anthony', 
      :height => 180
    )
    person.age = 34
    person.age        # returns 34

!SLIDE

    @@@ruby
    # set variable values on one line
    # logic in methods
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

!SLIDE

    @@@ruby
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

!SLIDE

    @@@ruby
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
    
    # Returns a new Person
    Person.find_or_create('Anthony')
    # Returns a new Person
    Person.find_or_create('John')
    # Returns Person named Anthony from above
    Person.find_or_create('Anthony')
