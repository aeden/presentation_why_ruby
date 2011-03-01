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
