class Crate
  attr_reader :x, :y, :width, :height, :product_code

  def initialize(x, y, width, height, product_code)
    @x = x
    @y = y
    @width = width
    @height = height
    @product_code = product_code
  end
end