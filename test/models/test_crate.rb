require_relative '../test_helper'
require './app/models/crate'
require './app/models/shelving_unit'

class TestCrate < Minitest::Test
  def setup
    @shelving_unit = ShelvingUnit.new(2, 5)
    @crate = Crate.new(0, 1, 2, 3, "P", 20)
  end

  def test_that_crate_has_correct_x_value
    assert_equal 0, @crate.x
  end

  def test_that_crate_has_correct_y_value
    assert_equal 1, @crate.y
  end

  def test_that_crate_has_correct_width_value
    assert_equal 2, @crate.width
  end

  def test_that_crate_has_correct_height_value
    assert_equal 3, @crate.height
  end

  def test_that_crate_has_correct_product_value
    assert_equal "P", @crate.product_code
  end

  def test_that_crate_has_correct_quantity
    assert_equal 20, @crate.quantity
  end

  def test_that_crate_has_correct_all_coordinates
    assert_equal [{ x: 0, y: 1 }, {x: 1, y: 1 }, { x: 0, y: 2 }, { x: 1, y: 2 }, { x: 0, y: 3 }, { x: 1, y: 3 }], @crate.all_crate_coords
  end
end