!SLIDE

# Testing #

!SLIDE

    @@@ruby
    class Person
      @people = {}
      def initialize(name)
        @name = name
      end
      def self.find_or_create(name)
        @people[name] ||= Person.new(name)
      end
    end

!SLIDE

# Test::Unit

!SLIDE smaller

    @@@ruby
    require 'test/unit'
    require 'person'

    class PersonTest < Test::Unit::TestCase
      def test_find_or_create_instantiates_person
        p1 = Person.find_or_create('Anthony Eden')
        assert_not_nil p1
      end
      def test_find_or_create_returns_same_person
        p2 = Person.find_or_create('Anthony Eden')
        assert p1 == p2
      end
    end

!SLIDE

# RSpec

!SLIDE smaller

    @@@ruby
    require 'rspec'
    require 'person'

    describe Person do
      let(:person) { Person.find_or_create('Anthony Eden') }

      describe "#find_or_create" do
        it "creates a person" do
          person.should_not be_nil
        end
        it "returns the same person" do
          Person.find_or_create('Anthony Eden').should eq(person)
        end
      end
    end

!SLIDE

# Cucumber
