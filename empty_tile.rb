class EmptyTile
  def initialize(tileCoordinate)
    @tileCoordinate=tileCoordinate
  end
  def isTileOccupied?
    false
  end
  def getPiece
    nil
  end
  def getCoordinate
    @tileCoordinate
  end
end