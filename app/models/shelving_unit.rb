require 'matrix'

class ShelvingUnit
  attr_reader :width, :height
  attr_accessor :representation

  def initialize(width, height)
    @width = width
    @height = height
    @representation = get_empty_representation(width, height)
  end

  def in_position(x, y)
    return false if (x > @width - 1 || y > @height - 1)

    representation[y][x]
  end

  def update_representation(coords, crate)
    representation[coords[:y]][coords[:x]] = crate
  end

  def print_to_screen
    ShelvingUnitPrinter.new(self).call
  end

  private

  def get_empty_representation(width, height)
    Matrix.build(height, width) { nil }.to_a
  end

end