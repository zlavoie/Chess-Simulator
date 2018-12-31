require './move'
require './board'
require './rook'
class Castle<Move
  def initialize(board,movedPiece,destination,castleRook,castleRookStart,castleRookDestination)
    super(board,movedPiece,destination)
    @castleRook=castleRook
    @castleRookStart=castleRookStart
    @castleRookDestination=castleRookDestination
  end
  def getCastleRook
    @castleRook
  end
  def isCastlingMove
    true
  end
  def execute
    newBoard=Board.new
    @board.getCurrentPlayer.getLivePieces.each do |piece|
      if (@movedPiece!=piece && @castleRook!=piece)
        newBoard.setPiece(piece)
      end
    end
    @board.getCurrentPlayer.getOpponent.getLivePieces.each do |piece|
      newBoard.setPiece(piece)
    end
    newBoard.setPiece(@movedPiece.movePiece(self))
    newBoard.setPiece(Rook.new(@castleRookDestination,@castleRook.getPieceAlliance,false))
    newBoard.setTurn(@board.getCurrentPlayer.getOpponent.getAlliance)
    newBoard.build
    newBoard
  end
end