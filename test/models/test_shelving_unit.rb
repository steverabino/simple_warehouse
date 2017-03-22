require_relative '../test_helper'
require './app/models/shelving_unit'
require './app/models/crate'

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
    assert_equal [[nil, nil, nil], [nil, nil, nil]], @shelving_unit.representation
  end

  def test_that_empty_shelf_position_is_reported
    position = @shelving_unit.in_position(1, 1)
    assert_nil position
  end

  def test_that_filled_shelf_position_reports_crate
    crate = Crate.new(1, 1, "P")
    @shelving_unit.representation[1][1] = crate
    position = @shelving_unit.in_position(1, 1)
    assert_equal crate, position
  end
end