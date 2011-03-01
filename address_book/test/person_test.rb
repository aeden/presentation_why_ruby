require 'test/unit'
require 'person'

class PersonTest < Test::Unit::TestCase
  def test_find_or_create_instantiates_person
    p = Person.find_or_create('Anthony Eden')
    assert_not_nil p
  end
  def test_find_or_create_returns_same_person
    p1 = Person.find_or_create('Anthony Eden')
    p2 = Person.find_or_create('Anthony Eden')
    assert p1 == p2
  end
end
