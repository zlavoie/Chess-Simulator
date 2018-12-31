class Piece
  def initialize(piecePosition,alliance,firstMove)
    @piecePosition=piecePosition
    @pieceAlliance=alliance
    @isFirstMove=firstMove
  end
  def calculateLegalMoves(board)
  end
  def getPieceAlliance
    @pieceAlliance
  end
  def isFirstMove
    @isFirstMove
  end
  def getPiecePosition
    @piecePosition
  end
  def ==(piece)
    ((to_s == piece.to_s)&&(@piecePosition==piece.getPiecePosition)&&(@pieceAlliance==piece.getPieceAlliance)&&(@isFirstMove==piece.isFirstMove))
  end
  def samePiece?(piece)
    (to_s==piece.to_s)
  end
end
