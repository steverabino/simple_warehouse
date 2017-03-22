class Crate
  attr_reader :x, :y, :width, :height, :product

  def initialize(x, y, width, height, product)
    @x = x
    @y = y
    @width = width
    @height = height
    @product = product
  end
end