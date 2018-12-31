require './attacking_move'
class PawnAttackMove<AttackingMove
  def initialize(board,movedPiece,destination,attackedPiece)
    super(board,movedPiece,destination,attackedPiece)
  end
  def ==(move)
    if(move.instance_of? PawnAttackMove)
      return (@movedPiece==move.getPiece && @destination==move.getDestination && move.getAttackedPiece==@attackedPiece)
    end
    false
  end
  def to_s
    "#{Utils.coordinateToString(@movedPiece.getPiecePosition)[0]}x#{Utils.coordinateToString(@destination)}"
  end
end