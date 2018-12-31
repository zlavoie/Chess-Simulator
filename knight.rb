require './piece'
require './utils'
require './major_attacking_move'
require './major_move'
class Knight<Piece

  def initialize(piecePosition,alliance,firstMove)
    super(piecePosition,alliance,firstMove)
    @CandidateMoves=Array[-17,-15,-10,-6,6,10,15,17]
  end
  def to_s
    'n'
  end
  def calculateLegalMoves(board)
    legalMoves=Array.new
    @CandidateMoves.each do |currentCandidate|
      candidateDestination = @piecePosition + currentCandidate
      if (Utils.isValidCoordinate(candidateDestination)&&!isException(@piecePosition,currentCandidate))
        candidateDestinationTile = board.getTile(candidateDestination)
        if (!candidateDestinationTile.isTileOccupied?)
          legalMoves.push(MajorMove.new(board,self,candidateDestination))
        else
          pieceAtDestination=candidateDestinationTile.getPiece
          pieceAtDestinationAlliance=pieceAtDestination.getPieceAlliance
          if(@pieceAlliance!=pieceAtDestinationAlliance)
            legalMoves.push(MajorAttackingMove.new(board,self,candidateDestination,pieceAtDestination))
          end
        end
      end
    end
    legalMoves
  end
  def isException(currentPosition,candidateMove)
    ((Utils.column?(1,currentPosition) && (candidateMove==-17||candidateMove==-10||candidateMove==6||candidateMove==15))   \
    ||(Utils.column?(2,currentPosition) && (candidateMove==-10||candidateMove==6))   \
    ||(Utils.column?(7,currentPosition) && (candidateMove==-6||candidateMove==10))  \
    ||(Utils.column?(8,currentPosition) && (candidateMove==-15||candidateMove==-6||candidateMove==10||candidateMove==17)))
  end
  def isKing?
    false
  end
  def movePiece(move)
    Knight.new(move.getDestination,move.getPiece.getPieceAlliance,false)
  end
  def getValue
    310
  end
  def getBonus
    if(@pieceAlliance==White.new)
      return Utils.whiteKnightBonus[@piecePosition]
    else
      return Utils.blackKnightBonus[@piecePosition]
    end
  end
end