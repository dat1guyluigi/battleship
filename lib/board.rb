require './cell'
require 'pry'

class Board
  attr_reader :cells

  def initialize
    @cells = create_cells
  end

  def create_cells
    cells_hash = {}
    numbers = [1, 2, 3, 4]
    letters = ["A", "B", "C", "D"]

    letters.each do |letter|
      numbers.each do |number|
        cell_name = letter + number.to_s
        cells_hash[cell_name] = Cell.new(cell_name)
      end
    end
    return cells_hash
  end

  def valid_coordinate?(coordinate)
    @cells.include? coordinate
  end

  def place(ship, coordinates)
    if valid_placement?(ship, coordinates)
      coordinates.each do |coordinate|
        @cells[coordinate].place_ship(ship)
      end
    end
  end

  def all_valid_placements?(coordinates_array)
    coordinates_array.all? do |coordinate_index|
      valid_coordinate?(coordinate_index)
    end
  end

  def consecutive_placements?(coordinates_array)
     horizontal_placement? || vertical_placement?
   end

  def horizontal_placement?(coordinates_array)
    coordinate_first_characters =
    coordinates_array.map do |coordinate|
      coordinate[0]
    end

    coordinate_first_characters.uniq.length !=
    coordinate_first_characters.length
  end

  def vertical_placement?(coordinates_array)
    coordinate_second_characters =
    coordinates_array.map do |coordinate|
      coordinate[1]
    end

    coordinate_second_characters.uniq.length !=
    coordinate_second_characters.length
  end

  def consecutive_vertical_placements?(coordinates_array)
    index_0 = coordinates_array.map {|coordinate| coordinate[0]}

    index_0 == (index_0.first..index_0.last).to_a
  end

  def consecutive_horizontal_placements?(coordinates_array)
    index_1 = coordinates_array.map {|coordinate| coordinate[1]}

    index_1 == (index_1.first..index_1.last).to_a
  end

  def ship_present?(coordinates_array)
    coordinates_array.any? do |coordinate|
       @cells[coordinate].empty? == false
    end
  end

  def duplicate_coordinates?(coordinates_array)
     coordinates_array != coordinates_array.uniq
  end

  def valid_placement?(ship, coordinates)
    !ship_present?(coordinates) &&
    ship.length == coordinates.length &&
    !duplicate_coordinates?(coordinates) &&
    all_valid_placements?(coordinates) &&
    horizontal_placement?(coordinates) ||
    vertical_placement?(coordinates) &&
    consecutive_vertical_placements?(coordinates) &&
    consecutive_horizontal_placements?(coordinates)
  end
end
