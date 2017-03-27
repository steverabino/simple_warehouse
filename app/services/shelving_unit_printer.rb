class ShelvingUnitPrinter
  def initialize(shelving_unit)
    @shelving_unit = shelving_unit
  end

  def call
    output = ""

    @shelving_unit.representation.reverse.each do |row|
      output += print_row(row)
    end

    output.chop
  end

  private

  def print_row(row)
    output = print_shelf_top
    output += "|"

    row.each do |cell|
      product_code = cell.nil? ? " " : cell.product_code
      output += " #{product_code} |"
    end

    output += "\n"
    output += print_shelf_bottom
  end

  def print_shelf_top
    output = "|"
    output += "   |" * @shelving_unit.width
    output += "\n"
  end

  def print_shelf_bottom
    output = "|"
    output += "___|" * @shelving_unit.width
    output += "\n"
  end
end
