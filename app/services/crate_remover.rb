class CrateRemover
  def initialize(shelving_unit, crate)
    @shelving_unit = shelving_unit
    @crate = crate
  end

  def call
    @crate.all_crate_coords.each do |coords|
      @shelving_unit.update_representation(coords, nil)
    end
  end
end