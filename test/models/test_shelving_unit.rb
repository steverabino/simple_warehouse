require_relative '../test_helper'
require './app/models/shelving_unit'

class TestShelvingUnit < Minitest::Test
  def setup
    @shelving_unit = ShelvingUnit.new(3, 2)
  end

  def test_that_shelving_unit_has_correct_width
    assert_equal 3, @shelving_unit.width
  end

  def test_that_shelving_unit_has_correct_height
    assert_equal 2, @shelving_unit.height
  end

  def test_that_shelving_unit_has_correct_empty_representation
    assert_equal Matrix[[nil, nil, nil], [nil, nil, nil]], @shelving_unit.representation
  end
end