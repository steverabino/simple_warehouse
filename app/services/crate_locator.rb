class CrateLocator
  def initialize(shelving_unit, product_code)
    @shelving_unit = shelving_unit
    @product_code = product_code
  end

  def call
    crates = []
    @shelving_unit.representation.each do |row|
      row.each do |column|
        unless column.nil?
          crates |= [column] if column.product_code == @product_code
        end
      end
    end
    locations = crates.each.map do |crate|
      crate = [crate.x, crate.y]
    end
  end
end