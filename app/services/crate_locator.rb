class CrateLocator
  def initialize(shelving_unit, product_code)
    @shelving_unit = shelving_unit
    @product_code = product_code
  end

  def call
    crates = []

    @shelving_unit.representation.each do |row|
      row.each do |cell|
        unless cell.nil?
          crates |= [cell] if cell.product_code == @product_code
        end
      end
    end

    crates.each.map do |crate|
      crate = "[x: #{crate.x}, y: #{crate.y}]"
    end
  end
end