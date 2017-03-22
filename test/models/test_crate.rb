require_relative '../test_helper'
require './app/models/crate'
require './app/models/shelving_unit'

class TestCrate < Minitest::Test
  def setup
    @shelving_unit = ShelvingUnit.new(2, 5)
    @crate = Crate.new(0, 1, 2, 3, "P")
  end

  def test_that_crate_has_correct_x
    assert_equal 0, @crate.x
  end

  def test_that_crate_has_correct_y
    assert_equal 1, @crate.y
  end

  def test_that_crate_has_correct_width
    assert_equal 2, @crate.width
  end

  def test_that_crate_has_correct_height
    assert_equal 3, @crate.height
  end

  def test_that_crate_has_correct_product
    assert_equal "P", @crate.product
  end
end