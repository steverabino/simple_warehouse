class CrateLocator
  def initialize(shelving_unit, product_code)
    @shelving_unit = shelving_unit
    @product_code = product_code
  end

  def call
    crates = []

    @shelving_unit.representation.each_with_index do |row, ri|
      row.each_with_index do |cell, ci|
        unless cell.nil?
          crates << "[x: #{ci}, y: #{ri}]" if cell.product_code == @product_code
        end
      end
    end

    crates

  end
end