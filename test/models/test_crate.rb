require_relative '../test_helper'
require './app/models/crate'
require './app/models/shelving_unit'

class TestCrate < Minitest::Test
  def setup
    @shelving_unit = ShelvingUnit.new(2, 5)
    @crate = Crate.new(2, 1, "P")
  end

  def test_that_crate_has_correct_width
    assert_equal 2, @crate.width
  end

  def test_that_crate_has_correct_height
    assert_equal 1, @crate.height
  end

  def test_that_crate_has_correct_product
    assert_equal "P", @crate.product
  end
end