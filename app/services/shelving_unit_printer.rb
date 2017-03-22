class ShelvingUnitPrinter
  def initialize(shelving_unit)
    @shelving_unit = shelving_unit
  end

  def call
    output = ""
    @shelving_unit.representation.reverse.each do |row|
      output += print_shelf_top
      output += "|"
      row.each do |column|
        product_code = column.nil? ? " " : column.product
        output += print_shelf_middle(product_code)
      end
      output += "\n"
      output += print_shelf_bottom
    end
    output.chop
  end

  private

  def print_shelf_top
    output = "|"
    output += "   |" * @shelving_unit.width
    output += "\n"
  end

  def print_shelf_middle(product_code)
    output = " #{product_code} |"
  end

  def print_shelf_bottom
    output = "|"
    output += "___|" * @shelving_unit.width
    output += "\n"
  end
end