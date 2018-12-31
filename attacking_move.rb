require './move'
require './utils'
class AttackingMove<Move
  def initialize(board,movedPiece,destination,attackedPiece)
    super(board,movedPiece,destination)
    @attackedPiece=attackedPiece
  end
  def isAttack
    true
  end
  def getAttackedPiece
    @attackedPiece
  end
  def to_s
    "#{@movedPiece.to_s.upcase}#{disambiguation}x#{Utils.coordinateToString(@destination)}"
  end
end
