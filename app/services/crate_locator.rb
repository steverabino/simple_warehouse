class CrateLocator
  def initialize(shelving_unit, product)
    @shelving_unit = shelving_unit
    @product = product
  end

  def call
    locations = []
    @shelving_unit.representation.each.with_index do |row, ri|
      row.each.with_index do |column, ci|
        unless column.nil?
          locations << [ci, ri] if column.product == @product
        end
      end
    end
    locations
  end
end