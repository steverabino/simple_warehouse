require_relative '../test_helper'
require './app/models/crate'
require './app/models/shelving_unit'
require './app/services/crate_storer'

class TestCrateStorer < Minitest::Test
  def setup
    @shelving_unit = ShelvingUnit.new(3, 3)
    @crate = Crate.new(1, 0, 2, 1, "P")
  end

  def test_that_valid_crate_is_stored_correctly
    CrateStorer.new(@shelving_unit, @crate).call
    assert_equal [[nil, @crate, @crate],[nil, nil, nil],[nil, nil, nil]], @shelving_unit.representation
  end

  def test_that_valid_crate_is_stored_next_to_another_correctly
    CrateStorer.new(@shelving_unit, @crate).call
    second_crate = Crate.new(0, 0, 1, 3, "Q")
    CrateStorer.new(@shelving_unit, second_crate).call
    assert_equal [[second_crate, @crate, @crate],[second_crate, nil, nil],[second_crate, nil, nil]], @shelving_unit.representation
  end

  def test_that_crate_cannot_be_stored_outside_x_bounds_of_shelving_unit
    crate = Crate.new(3, 1, 2, 1, "P")
    storage = CrateStorer.new(@shelving_unit, crate).call
    assert_equal false, storage
  end

  def test_that_crate_cannot_be_stored_outside_y_bounds_of_shelving_unit
    crate = Crate.new(1, 4, 2, 1, "P")
    storage = CrateStorer.new(@shelving_unit, crate).call
    assert_equal false, storage
  end

  def test_that_crate_cannot_be_stored_overlapping_bounds_of_shelving_unit
    crate = Crate.new(2, 2, 2, 2, "P")
    storage = CrateStorer.new(@shelving_unit, crate).call
    assert_equal false, storage
  end

  def test_that_crate_cannot_be_stored_in_another_crates_spot
    CrateStorer.new(@shelving_unit, @crate).call
    storage = CrateStorer.new(@shelving_unit, @crate).call
    assert_equal false, storage
  end

  def test_that_crate_cannot_be_stored_over_bounds_of_another_crate
    CrateStorer.new(@shelving_unit, @crate).call
    crate = Crate.new(2, 0, 2, 1, "P")
    storage = CrateStorer.new(@shelving_unit, crate).call
    assert_equal false, storage
  end
end
