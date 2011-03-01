!SLIDE

# Inheritence and Mix-ins #

!SLIDE

    @@@ruby
    # inheritence
    class Employee < Person
      attr_accessor :number
    end
    person = Employee.new(:name => 'Anthony')
    person.number = 1000

    person = Person.new(:name => 'Anthony')
    
    # raises an error
    # NoMethodError: undefined method 'number='
    person.number = 1000

!SLIDE

    @@@ruby
    # modules for functionality
    module Employable
      attr_accessor :number
    end
    class Person
      include Employable
    end
    person = Person.new(:name => 'Anthony')
    person.number = 1000

!SLIDE

    @@@ruby
    # modules for namespacing
    module AddressBook
      class Person
      end
    end
    person = AddressBook::Person.new

!SLIDE

    @@@ruby
    # OR-equal operator, append operator, 
    # extending an instance with a module
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
