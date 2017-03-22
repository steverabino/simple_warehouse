class CrateStorer
  def initialize(shelving_unit, x, y, crate)
    @shelving_unit = shelving_unit
    @x = x
    @y = y
    @crate = crate
  end

  def call
    coords = crate_position_coordinates(@crate, @x, @y)
    if crate_fits_in_shelving_unit?(coords, @shelving_unit)
      coords.each { |coord| @shelving_unit.representation[coord[:y]][coord[:x]] = @crate }
    else
      return false
    end
  end

  private

  def crate_position_coordinates(crate, x, y)
    arr = []
    crate.height.times do |row|
      crate.width.times do |column|
        arr << { x: x + column, y: y + row }
      end
    end
    arr
  end

  def crate_fits_in_shelving_unit? coords, shelving_unit
    coords.all? { |coord| @shelving_unit.in_position(coord[:x], coord[:y]) == nil }
  end
end