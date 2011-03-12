module AddressBook
  class Person
    @people = {}
    def initialize(name)
      @name = name
    end
    def self.find_or_create(name)
      @people[name] ||= Person.new(name)
    end
  end
end
