require './empty_tile'
require './occupied_tile'
class Tile
  def self.createTile(tileCoordinate,piece)
    if (piece!=nil)
      return OccupiedTile.new(tileCoordinate,piece)
    else
      return EmptyTile.new(tileCoordinate)
    end
  end
end
