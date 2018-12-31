class OccupiedTile
  def initialize(tileCoordinate,pieceOnTile)
    @tileCoordinate=tileCoordinate
    @pieceOnTile=pieceOnTile
  end
  def isTileOccupied?
    true
  end
  def getPiece
    @pieceOnTile
  end
  def getCoordinate
    @tileCoordinate
  end
end