require './castle'
class KingSideCastle<Castle
  def initialize(board,movedPiece,destination,castleRook,castleRookStart,castleRookDestination)
    super(board,movedPiece,destination,castleRook,castleRookStart,castleRookDestination)
  end
  def ==(move)
    if(move.instance_of? KingSideCastle)
      return (@movedPiece==move.getPiece && @destination==move.getDestination && @castleRook==move.getCastleRook)
    end
    false
  end
  def to_s
    "O-O"
  end
end