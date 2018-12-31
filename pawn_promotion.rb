require './move'
require './board'
class PawnPromotion<Move
  def initialize(move,promotedPiece)
    super(move.getBoard,move.getPiece,move.getDestination)
    @pawnMove=move
    @pawn=move.getPiece
    @promotedPiece=promotedPiece
  end
  def isAttack
    @pawnMove.isAttack
  end
  def getAttackedPiece
    @pawnMove.getAttackedPiece
  end
  def execute
    movedBoard=@pawnMove.execute
    newBoard=Board.new
    movedBoard.getCurrentPlayer.getOpponent.getLivePieces.each do |piece|
      if (@movedPiece!=piece)
        newBoard.setPiece(piece)
      end
    end
    movedBoard.getCurrentPlayer.getLivePieces.each do |piece|
      newBoard.setPiece(piece)
    end
    newBoard.setPiece(@promotedPiece)
    newBoard.setTurn(movedBoard.getCurrentPlayer.getAlliance)
    newBoard.build
    newBoard
  end
  def ==(move)
    if(move.instance_of? PawnPromotion)
      return (@movedPiece==move.getPiece && @destination==move.getDestination)
    end
    false
  end
  def to_s
    "#{@pawnMove.to_s}=#{@promotedPiece.to_s.upcase}"
  end
end

