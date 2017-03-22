require 'matrix'

class ShelvingUnit
  attr_reader :width, :height
  attr_accessor :representation

  def initialize(width, height)
    @width = width
    @height = height
    @representation = get_empty_representation(width, height)
  end

  private

  def get_empty_representation(width, height)
    Matrix.build(height, width) { nil }
    # If working with Matrix is too much, you can use the .to_a method later
  end

end