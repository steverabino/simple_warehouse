class Crate
  attr_reader :width, :height, :product

  def initialize(width, height, product)
    @width = width
    @height = height
    @product = product
  end
end