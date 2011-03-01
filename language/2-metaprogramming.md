!SLIDE

# Metaprogramming #

!SLIDE

    @@@ruby
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

!SLIDE 

    @@@ruby
    # sidebar: each
    people = ['John', 'Jane', 'Jim']
    for person in people
      p person
    end

    people.each do |person|
      p person
    end

    people.each { |person| p person }

!SLIDE 

    @@@ruby
    # with a method that does not exist an error is raised
    class Person
      attr_accessor :name, :age, :height

      def initialize(attributes={})
        attributes.each do |name, value|
          send("#{name}=", value)
        end
      end
    end

    # raises an error
    person = Person.new(:eye_color => :green)

!SLIDE

    @@@ruby
    # respond_to? to check existence of method
    class Person
      attr_accessor :name, :age, :height

      def initialize(attributes={})
        attributes.each do |name, value|
          if respond_to?("#{name}=")
            send("#{name}=", value)
          end
        end
      end
    end

    # no longer raises an error
    person = Person.new(:eye_color => :green)

!SLIDE

    @@@ruby
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

!SLIDE

    @@@ruby
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

!SLIDE

    @@@ruby
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

!SLIDE

    @@@ruby
    # refactoring into private methods
    class Person
      def initialize(attributes={})
        attributes.each do |name, value|
          set_attribute(name, value)
        end
      end
      
      private  # private from here down
      def set_attribute(name, value)
        unless respond_to?("#{name}=")
          Person.instance_eval do
            attr_accessor name
          end
        end
        send("#{name}=", value)
      end
    end

!SLIDE

    @@@ruby
    person = Person.new(:name => 'Anthony')
    person.name   # returns 'Anthony'

    # raises a NoMethodError
    # private method 'set_attribute' called for
    # <Person:0x00000101082b48 @name="Anthony">
    person.set_attribute('sex', 'male')
    

