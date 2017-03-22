require_relative 'test_helper'
require './app/simple_warehouse'

class TestSimpleWarehouse < Minitest::Test
  def setup
    @app = SimpleWarehouse.new
  end

  def test_that_init_command_creates_shelving_unit
    @app.interpret_command("init 3 2")
    assert_equal 3, @app.shelving_unit.width
    assert_equal 2, @app.shelving_unit.height
  end

  def test_that_init_command_replaces_existing_shelving_unit
    @app.interpret_command("init 3 2")
    @app.interpret_command("init 2 3")
    assert_equal 2, @app.shelving_unit.width
    assert_equal 3, @app.shelving_unit.height
  end

  def test_that_init_command_creates_correct_output
    output = @app.interpret_command("init 3 2")
    assert_equal "Empty shelving unit of width: 3 and height: 2 created", output
  end

  def test_that_store_command_creates_storage
    @app.interpret_command("init 3 2")
    @app.interpret_command("store 1 1 2 1 P")
    assert_equal "P", @app.shelving_unit.in_position(1,1).product_code
    assert_equal "P", @app.shelving_unit.in_position(2,1).product_code
  end

  def test_that_locate_command_shows_locations
    @app.interpret_command("init 3 2")
    @app.interpret_command("store 1 1 2 1 P")
    output = @app.interpret_command("locate P")
    assert_equal "Product P can be found at the following locations: [x: 1, y: 1]", output
  end

  def test_that_locate_command_shows_out_of_stock_message
    @app.interpret_command("init 3 2")
    @app.interpret_command("store 1 1 2 1 P")
    output = @app.interpret_command("locate Q")
    assert_equal "We out out of stock of product Q", output
  end

  def test_that_remove_command_removes_the_product
    @app.interpret_command("init 3 2")
    @app.interpret_command("store 1 1 2 1 P")
    output = @app.interpret_command("remove 2 1")
    assert_nil @app.shelving_unit.in_position(2, 1)
    assert_equal "Product P removed from location [x: 2, y: 1] (crate origin: [x: 1, y: 1])", output
  end

  def test_print_command
    @app.interpret_command("init 3 2")
    @app.interpret_command("store 1 0 2 1 P")
    output = @app.interpret_command("view")
    assert_equal "|   |   |   |\n|   |   |   |\n|___|___|___|\n|   |   |   |\n|   | P | P |\n|___|___|___|", output
  end
end