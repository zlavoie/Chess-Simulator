require './pawn_attack_move'
require './board'
class EnPassant<PawnAttackMove
  def initialize(board,movedPiece,destination,attackedPiece)
    super(board,movedPiece,destination,attackedPiece)
  end
  def execute
    newBoard=Board.new
    @board.getCurrentPlayer.getLivePieces.each do |piece|
      if (@movedPiece!=piece)
        newBoard.setPiece(piece)
      end
    end
    @board.getCurrentPlayer.getOpponent.getLivePieces.each do |piece|
      if(@attackedPiece!=piece)
        newBoard.setPiece(piece)
      end 
    end
    newBoard.setPiece(@movedPiece.movePiece(self))
    newBoard.setTurn(@board.getCurrentPlayer.getOpponent.getAlliance)
    newBoard.build
    newBoard
  end
  def to_s
    "#{super}e.p."
  end
end