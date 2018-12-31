require './board'
class Move
  def initialize(board,movedPiece,destination)
    @board=board
    @movedPiece=movedPiece
    @destination=destination
  end
  def getPiece
    @movedPiece
  end
  def getBoard
    @board
  end
  def getDestination
    @destination
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
    newBoard.setPiece(@movedPiece.movePiece(self))
    newBoard.setTurn(@board.getCurrentPlayer.getOpponent.getAlliance)
    newBoard.build
    newBoard
  end
  def getCoordinate
    @movedPiece.getPiecePosition
  end
  def createMove(board,coordinate,destinationCoordinate)
    board.getAllLegalMoves.each do |move|
      if(move.getDestination==destinationCoordinate and move.getCoordinate==coordinate)
        return move
      end
    end
  end
  def isAttack
    false
  end
  def isCastlingMove
    false
  end
  def getAttackedPiece
    nil
  end
  def disambiguation
    same=0
    col=0
    row=0
    @board.getCurrentPlayer.getLegalMoves.each do |move|
      if(move.getDestination==@destination && move!=self && @movedPiece.samePiece?(move.getPiece))
        same+=1
        if(Utils.column(move.getPiece.getPiecePosition)==Utils.column(@movedPiece.getPiecePosition))
          col+=1
        elsif(Utils.row(move.getPiece.getPiecePosition)==Utils.row(@movedPiece.getPiecePosition))
          row+=1
        end
      end
    end
    if(same!=0)
      if(col==0)
        return Utils.coordinateToString(@movedPiece.getPiecePosition)[0]
      elsif(col!=0 && row==0)
        return Utils.coordinateToString(@movedPiece.getPiecePosition)[1]
      else
        return Utils.coordinateToString(@movedPiece.getPiecePosition)
      end
    end
  end
  return ""
end