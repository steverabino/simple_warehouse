# TODO: require_all gem may come in handy!

require './app/models/shelving_unit'
require './app/models/crate'
require './app/services/crate_storer'
require './app/services/crate_locator'
require './app/services/shelving_unit_printer'

class SimpleWarehouse
  def run
    @live = true
    puts 'Type `help` for instructions on usage'
    while @live
      print '> '
      interpret_command(gets.chomp)
    end
  end

  def interpret_command(command)
    arr = command.split(" ")
    verb, *args = arr
    case verb
    when 'help'
      output = show_help_message
    when 'init'
      output = create_empty_shelving_unit(args)
    when 'store'
      output = store_crate(args)
    when 'locate'
      output = locate_crate(args)
    when 'view'
      output = @shelving_unit.print_to_screen
    when 'exit'
      output = exit
    else
      output = show_unrecognized_message
    end
    ENV['testmode'] ? output : puts(output)
  end

  def shelving_unit
    @shelving_unit
  end

  private

  def show_help_message
    return 'help             Shows this help message
init W H         (Re)Initialises the application as a W x H warehouse, with all spaces empty.
store X Y W H P  Stores a crate of product number P and of size W x H at position X,Y.
locate P         Show a list of positions where product number can be found.
remove X Y       Remove the crate at positon X,Y.
view             Show a representation of the current state of the warehouse, marking each position as filled or empty.
exit             Exits the application.'
  end

  def create_empty_shelving_unit(args)
    @shelving_unit = ShelvingUnit.new(args[0].to_i, args[1].to_i)
    return "Empty shelving unit of width: #{args[0]} and height: #{args[1]} created"
  end

  def store_crate(args)
    crate = Crate.new(args[2].to_i, args[3].to_i, args[4])
    if CrateStorer.new(@shelving_unit, args[0].to_i, args[1].to_i, crate).call
      return "Crate of product #{args[4]} has been placed at coords #{args[0]}, #{args[1]}"
    else
      return "Invalid placement of crate; please try again."
    end
  end

  def locate_crate(args)
    locations = CrateLocator.new(@shelving_unit, args[0]).call
    if locations.empty?
      return "We out out of stock of product #{args[0]}"
    else
      location_output = ""
      locations.each do |location|
        location_output += "[x: #{location[0]}, y: #{location[1]}], "
      end
      return "Product #{args[0]} can be found at the following locations: #{location_output.chop.chop}"
    end
  end

  def show_unrecognized_message
    return 'Command not found. Type `help` for instructions on usage'
  end

  def exit
    @live = false
    return 'Thank you for using simple_warehouse!'
  end
end
