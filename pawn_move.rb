require './move'
class PawnMove<Move
  def initialize(board,movedPiece,destination)
    super(board,movedPiece,destination)
  end
  def ==(move)
    if(move.instance_of? PawnJump)
      return (@movedPiece==move.getPiece && @destination==move.getDestination)
    end
    false
  end
  def to_s
    "#{Utils.coordinateToString(@destination)}"
  end
end