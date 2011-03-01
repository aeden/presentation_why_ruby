require 'test/unit'
require 'person'

class PersonTest < Test::Unit::TestCase
  def test_find_or_create
    p1 = Person.find_or_create('Anthony Eden')
    assert_not_nil p1
    p2 = Person.find_or_create('Anthony Eden')
    assert p1 == p2
  end
end
