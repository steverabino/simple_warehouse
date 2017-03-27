require_relative '../test_helper'
require './app/models/crate'
require './app/models/shelving_unit'
require './app/services/crate_taker'

class TestCrateTaker < Minitest::Test
  def setup
    @shelving_unit = ShelvingUnit.new(3, 3)
    @crate = Crate.new(1, 0, 2, 2, "P", 20)
    CrateStorer.new(@shelving_unit, @crate).call
  end

  def test_take_one_unit_from_crate_does_not_affect_size
    CrateTaker.new(@shelving_unit, @crate, 1).call
    assert_equal 2, @crate.height
    assert_equal 2, @crate.width
    assert_equal [[nil, @crate, @crate],[nil, @crate, @crate],[nil, nil, nil]], @shelving_unit.representation
  end

  def test_take_nine_units_from_crate_does_not_affect_size
    CrateTaker.new(@shelving_unit, @crate, 9).call
    assert_equal 2, @crate.height
    assert_equal 2, @crate.width
    assert_equal [[nil, @crate, @crate],[nil, @crate, @crate],[nil, nil, nil]], @shelving_unit.representation
  end

  def test_take_ten_units_from_crate_reduces_height_by_one
    CrateTaker.new(@shelving_unit, @crate, 10).call
    assert_equal 1, @crate.height
    assert_equal 2, @crate.width
    assert_equal [[nil, @crate, @crate],[nil, nil, nil],[nil, nil, nil]], @shelving_unit.representation
  end

  def test_take_twenty_units_from_crate_removes_crate
    CrateTaker.new(@shelving_unit, @crate, 20).call
    assert_equal 0, @crate.height
    assert_equal 2, @crate.width
    assert_equal [[nil, nil, nil],[nil, nil, nil],[nil, nil, nil]], @shelving_unit.representation
  end

  def test_take_twenty_one_units_from_crate_does_nothing
    CrateTaker.new(@shelving_unit, @crate, 21).call
    assert_equal 2, @crate.height
    assert_equal 2, @crate.width
    assert_equal [[nil, @crate, @crate],[nil, @crate, @crate],[nil, nil, nil]], @shelving_unit.representation
  end

end