require './piece'
require './utils'
require './major_attacking_move'
require './major_move'
class King<Piece
  def initialize(piecePosition,alliance,firstMove,isCastled)
    super(piecePosition,alliance,firstMove)
    @isCastled=isCastled
    @CandidateMoves=Array[-9,-8,-7,-1,1,7,8,9]
  end
  def to_s
    'k'
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
          if @pieceAlliance!=pieceAtDestinationAlliance
            legalMoves.push(MajorAttackingMove.new(board,self,candidateDestination,pieceAtDestination))
          end
        end
      end
    end
    legalMoves
  end
  def isException(currentPosition,candidateMove)
    ((Utils.column?(1,currentPosition) && (candidateMove==-9||candidateMove==-1||candidateMove==7))   \
    ||(Utils.column?(8,currentPosition) && (candidateMove==-7||candidateMove==1||candidateMove==9)))
  end
  def isKing?
    true
  end
  def movePiece(move)
    King.new(move.getDestination,move.getPiece.getPieceAlliance,false,move.isCastlingMove)
  end
  def getValue
    10000
  end
  def isCastled
    @isCastled
  end
  def getBonus
    if(@pieceAlliance==White.new)
      return Utils.whiteKingBonus[@piecePosition]
    else
      return Utils.blackKingBonus[@piecePosition]
    end
  end
end