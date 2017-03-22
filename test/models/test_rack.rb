require_relative '../test_helper'

class TestRack < Minitest::Test
  def setup
    @rack = Rack.new(3, 2)
  end

  def test_that_rack_has_correct_width
    assert_equal 3, @rack.width
  end

  def test_that_rack_has_correct_height
    assert_equal 2, @rack.height
  end

  def test_that_rack_has_correct_empty_representation
    assert_equal [[nil, nil, nil],[nil, nil, nil]], @rack.representation
  end
end