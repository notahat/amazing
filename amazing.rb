require 'location'
require 'grid'
require 'maze'
require 'printer'

require 'set'

class Set
  def random
    empty? ? nil : to_a[rand(length)]
  end
end

class Generator
  def generate(maze)
    connected_locations = Set.new

    location = maze.locations.first
    connected_locations << location

    adjacent_locations = location.neighbours & maze.locations

    until adjacent_locations.empty?
      location = adjacent_locations.random
      adjacent_locations.delete(location)

      neighbour = (location.neighbours & connected_locations).random
      maze.add_route(location, neighbour)
      connected_locations << location

      unconnected_locations = maze.locations - connected_locations
      adjacent_locations |= (location.neighbours & unconnected_locations)
    end
  end
end

size = 20
locations = Grid.new(size).locations
maze = Maze.new(locations)

Generator.new.generate(maze)

puts Printer.new(maze, size).print

