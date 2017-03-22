require_relative '../test_helper'
require './app/models/crate'
require './app/models/shelving_unit'
require './app/services/crate_remover'
require './app/services/crate_storer'


class TestCrateRemover < Minitest::Test
  def setup
    @shelving_unit = ShelvingUnit.new(3, 3)
    @crate = Crate.new(2, 1, "P")
    CrateStorer.new(@shelving_unit, 1, 0, @crate).call
  end

  def test_that_valid_crate_is_removed_correctly
    CrateRemover.new(@shelving_unit, 2, 1).call
    assert_nil @shelving_unit.in_position(2, 1)
  end

  def test_that_empty_shelf_is_removed_correctly
    CrateRemover.new(@shelving_unit, 2, 2).call
    assert_nil @shelving_unit.in_position(2, 2)
  end
end