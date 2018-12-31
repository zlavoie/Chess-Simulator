require './attacking_move'
class MajorAttackingMove<AttackingMove
  def initialize(board,movedPiece,destination,attackedPiece)
    super(board,movedPiece,destination,attackedPiece)
  end
  def ==(move)
    if(move.instance_of? MajorAttackingMove)
      return (@movedPiece==move.getPiece && @destination==move.getDestination && @attackedPiece==move.getAttackedPiece)
    end
    false
  end
end