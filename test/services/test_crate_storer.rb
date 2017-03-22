require_relative '../test_helper'
require './app/models/crate'
require './app/models/shelving_unit'
require './app/services/crate_storer'

class TestCrateStorer < Minitest::Test
  def setup
    @shelving_unit = ShelvingUnit.new(4, 5)
    @crate = Crate.new(2, 1, "P")
    CrateStorer.new(@shelving_unit, @crate, 1, 0).call
  end

  def test_that_valid_crate_is_stored
    assert_equal 3, @shelving_unit.width
  end

  def test_that_crate_cannot_be_stored_outside_bounds_of_shelving_unit
    storage = CrateStorer.new(@shelving_unit, @crate, 3, 1).call
    assert_equal false/fail/nil
  end

  def test_that_crate_cannot_be_stored_in_another_crates_spot
    CrateStorer.new(@shelving_unit, @crate, 1, 0).call
    assert_equal false/fail/nil
  end
end
