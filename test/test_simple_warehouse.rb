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

  def test_that_store_command_creates_storage
    @app.interpret_command("init 3 2")
    @app.interpret_command("store 1 1 2 1 P")
    assert_equal "P", @app.shelving_unit.in_position(1,1).product
    assert_equal "P", @app.shelving_unit.in_position(2,1).product
  end

  def test_that_init_command_creates_correct_output
    output = @app.interpret_command("init 3 2")
    assert_equal "Empty shelving unit of width: 3 and height: 2 created", output
  end
end