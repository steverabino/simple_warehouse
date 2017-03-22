require_relative '../test_helper'
require './app/models/crate'
require './app/models/shelving_unit'
require './app/services/crate_storer'
require './app/services/shelving_unit_printer'


class TestCratePrinter < Minitest::Test
  def setup
    @shelving_unit = ShelvingUnit.new(3, 2)
    @crate = Crate.new(1, 0, 2, 1, "P")
    CrateStorer.new(@shelving_unit, @crate).call
  end

  def test_that_the_printout_is_correct
    output = @shelving_unit.print_to_screen
    assert_equal "|   |   |   |\n|   |   |   |\n|___|___|___|\n|   |   |   |\n|   | P | P |\n|___|___|___|", output
  end
end