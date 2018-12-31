require './move'
require './board'
class PawnJump<Move
  def initialize(board,movedPiece,destination)
    super(board,movedPiece,destination)
  end
  def execute
    newBoard=Board.new
    @board.getCurrentPlayer.getLivePieces.each do |piece|
      if (@movedPiece!=piece)
        newBoard.setPiece(piece)
      end
    end
    @board.getCurrentPlayer.getOpponent.getLivePieces.each do |piece|
      newBoard.setPiece(piece)
    end
    movedPawn=@movedPiece.movePiece(self)
    newBoard.setPiece(movedPawn)
    newBoard.setTurn(@board.getCurrentPlayer.getOpponent.getAlliance)
    newBoard.setEnPassantPawn(movedPawn)
    newBoard.build
    newBoard
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