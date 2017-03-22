require_relative '../test_helper'
require './app/models/crate'
require './app/models/shelving_unit'
require './app/services/crate_locator'
require './app/services/crate_storer'


class TestCrateLocator < Minitest::Test
  def setup
    @shelving_unit = ShelvingUnit.new(3, 3)
    @crate = Crate.new(2, 1, "P")
    CrateStorer.new(@shelving_unit, 1, 0, @crate).call
  end

  def test_that_valid_crate_is_located_correctly
    locations = CrateLocator.new(@shelving_unit, "P").call
    assert_equal [[1, 0], [2, 0]], locations
  end

  def test_that_multiple_valid_crates_are_located_correctly
    CrateStorer.new(@shelving_unit, 1, 2, @crate).call
    locations = CrateLocator.new(@shelving_unit, "P").call
    assert_equal [[1, 0], [2, 0], [1, 2], [2, 2]], locations
  end

  def test_that_alternative_products_are_ignored
    @crate2 = Crate.new(2, 1, "Q")
    CrateStorer.new(@shelving_unit, 1, 2, @crate2).call
    locations = CrateLocator.new(@shelving_unit, "P").call
    assert_equal [[1, 0], [2, 0]], locations
  end

  def test_that_invalid_product_is_not_located
    locations = CrateLocator.new(@shelving_unit, "Q").call
    assert_equal [], locations
  end
end