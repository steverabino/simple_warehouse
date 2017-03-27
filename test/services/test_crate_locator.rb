require_relative '../test_helper'
require './app/models/crate'
require './app/models/shelving_unit'
require './app/services/crate_locator'
require './app/services/crate_storer'


class TestCrateLocator < Minitest::Test
  def setup
    @shelving_unit = ShelvingUnit.new(3, 3)
    @crate = Crate.new(1, 0, 2, 1, "P", 20)
    CrateStorer.new(@shelving_unit, @crate).call
  end

  def test_that_valid_crate_is_located_correctly
    locations = CrateLocator.new(@shelving_unit, "P").call
    assert_equal ["[x: 1, y: 0]", "[x: 2, y: 0]"], locations
  end

  def test_that_multiple_valid_crates_are_located_correctly
    CrateStorer.new(@shelving_unit, @crate).call
    crate = Crate.new(0, 1, 2, 1, "P", 20)
    CrateStorer.new(@shelving_unit, crate).call
    locations = CrateLocator.new(@shelving_unit, "P").call
    assert_equal ["[x: 1, y: 0]", "[x: 2, y: 0]", "[x: 0, y: 1]", "[x: 1, y: 1]"], locations
  end

  def test_that_alternative_products_are_ignored
    crate = Crate.new(1, 2, 2, 1, "Q", 20)
    CrateStorer.new(@shelving_unit, crate).call
    locations = CrateLocator.new(@shelving_unit, "P").call
    assert_equal ["[x: 1, y: 0]", "[x: 2, y: 0]"], locations
  end

  def test_that_invalid_product_is_not_located
    locations = CrateLocator.new(@shelving_unit, "Q").call
    assert_equal [], locations
  end
end