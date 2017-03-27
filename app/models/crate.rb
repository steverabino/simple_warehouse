class Crate
  attr_reader :x, :y, :product_code
  attr_accessor :quantity

  def initialize(x, y, width, height, product_code, quantity)
    @x = x
    @y = y
    @width = width.to_f
    @height = height.to_f
    @product_code = product_code
    @quantity = quantity
  end

  def height
    @height.ceil
  end

  def width
    @width.ceil
  end

  def all_crate_coords
    arr = []

    height.times do |row|
      width.times do |cell|
        arr << { x: @x + cell, y: @y + row }
      end
    end

    arr
  end

  def reduce_quantity_by(quantity)
    @height -= (quantity / @quantity.to_f) * @height
    @quantity -= quantity
  end
end
