class CrateRemover
  def initialize(shelving_unit, x, y)
    @shelving_unit = shelving_unit
    @x = x
    @y = y
  end

  def call
    @shelving_unit.representation[@y][@x] = nil
  end
end