class Crate
  attr_reader :x, :y, :width, :height, :product_code
  attr_accessor :quantity

  def initialize(x, y, width, height, product_code, quantity)
    @x = x
    @y = y
    @width = width
    @height = height
    @product_code = product_code
    @quantity = quantity
  end

  def all_crate_coords
    arr = []

    @height.times do |row|
      @width.times do |cell|
        arr << { x: @x + cell, y: @y + row }
      end
    end

    arr
  end
end