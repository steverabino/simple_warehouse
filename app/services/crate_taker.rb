require_relative 'crate_remover'
require_relative 'crate_storer'

class CrateTaker
  def initialize(shelving_unit, crate, quantity)
    @shelving_unit = shelving_unit
    @crate = crate
    @quantity = quantity
  end

  def call
    if @crate.nil? || @quantity > @crate.quantity
      false
    else
      CrateRemover.new(@shelving_unit, @crate).call
      @crate.reduce_quantity_by(@quantity)
      CrateStorer.new(@shelving_unit, @crate).call
    end
  end
end
