require_relative '../test_helper'
require './app/models/crate'
require './app/models/shelving_unit'
require './app/services/crate_storer'

class TestCrateStorer < Minitest::Test
  def setup
    @shelving_unit = ShelvingUnit.new(3, 3)
    @crate = Crate.new(2, 1, "P")
  end

  def test_that_valid_crate_is_stored_correctly
    CrateStorer.new(@shelving_unit, 1, 0, @crate).call
    assert_equal [[nil, @crate, @crate],[nil, nil, nil],[nil, nil, nil]], @shelving_unit.representation
  end

  def test_that_crate_cannot_be_stored_outside_x_bounds_of_shelving_unit
    storage = CrateStorer.new(@shelving_unit, 3, 1, @crate).call
    assert_equal false, storage
  end

  def test_that_crate_cannot_be_stored_outside_y_bounds_of_shelving_unit
    storage = CrateStorer.new(@shelving_unit, 3, 4, @crate).call
    assert_equal false, storage
  end

  def test_that_crate_cannot_be_stored_over_bounds_of_shelving_unit
    storage = CrateStorer.new(@shelving_unit, 3, 2, @crate).call
    assert_equal false, storage
  end

  def test_that_crate_cannot_be_stored_in_another_crates_spot
    CrateStorer.new(@shelving_unit, 1, 0, @crate).call
    storage = CrateStorer.new(@shelving_unit, 1, 0, @crate).call
    assert_equal false, storage
  end

  def test_that_crate_cannot_be_stored_over_bounds_of_another_crate
    CrateStorer.new(@shelving_unit, 1, 0, @crate).call
    storage = CrateStorer.new(@shelving_unit, 0, 0, @crate).call
    assert_equal false, storage
  end
end
