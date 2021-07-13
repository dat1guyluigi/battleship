require './lib/cell'
require './lib/ship'

RSpec.describe Cell do

  context 'initialize' do
    cell = Cell.new('B4')

    it 'exists with attributes' do
      expect(cell).to be_a(Cell)
      expect(cell.coordinate).to eq('B4')
    end

    it 'The cell starts empty' do
      expect(cell.ship).to eq(nil)
      expect(cell.empty?).to eq(true)
    end

    it 'can have a ship placed in it' do
      cruiser = Ship.new("Cruiser", 3)
      cell.place_ship(cruiser)

      expect(cell.ship).to eq(cruiser)
      expect(cell.empty?).to eq(false)
    end

    it 'knows when it has taken a hit' do
      cruiser = Ship.new("Cruiser", 3)
      cell.place_ship(cruiser)

      expect(cell.fired_upon?).to eq(false)

      cell.fire_upon

      expect(cell.ship.health).to eq(2)
      expect(cell.fired_upon?).to eq(true)
    end

    it 'Has a method render' do
      cell_1 = Cell.new("B4")
      cruiser = Ship.new("Cruiser", 3)
      # cell_1.place_ship(cruiser)


      expect(cell_1.render).to eq('.')

      cell_1.fire_upon

      expect(cell_1.render).to eq('M')




    end
  end
end
