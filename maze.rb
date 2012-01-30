require 'location'

class Maze

  def initialize(locations)
    @locations = locations.clone
    @routes = {}
  end

  attr_reader :locations

  def add_route(source, destination)
    add_route_one_way(source, destination)
    add_route_one_way(destination, source)
  end

  def has_route?(source, destination)
    @routes.has_key?(source) && @routes[source].include?(destination)
  end

private

  def add_route_one_way(source, destination)
    @routes[source] ||= []
    @routes[source] << destination
  end

end
