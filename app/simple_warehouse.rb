# TODO: require_all gem may come in handy!

require './app/models/shelving_unit'

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
      show_help_message
    when 'init'
      create_empty_shelving_unit(args)
    when 'exit'
      exit
    else
      show_unrecognized_message
    end
  end

  def shelving_unit
    @shelving_unit
  end

  private

  def show_help_message
    puts 'help             Shows this help message
init W H         (Re)Initialises the application as a W x H warehouse, with all spaces empty.
store X Y W H P  Stores a crate of product number P and of size W x H at position X,Y.
locate P         Show a list of positions where product number can be found.
remove X Y       Remove the crate at positon X,Y.
view             Show a representation of the current state of the warehouse, marking each position as filled or empty.
exit             Exits the application.'
  end

  def create_empty_shelving_unit(args)
    @shelving_unit = ShelvingUnit.new(args[0].to_i, args[1].to_i)
    puts "Empty shelving unit of width: #{args[0]} and height: #{args[1]} created"
  end

  def show_unrecognized_message
    puts 'Command not found. Type `help` for instructions on usage'
  end

  def exit
    puts 'Thank you for using simple_warehouse!'
    @live = false
  end
end
