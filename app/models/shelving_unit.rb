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
    begin
      @representation[x][y]
    rescue NoMethodError
      false
    end
  end

  private

  def get_empty_representation(width, height)
    Matrix.build(height, width) { nil }.to_a
  end

end