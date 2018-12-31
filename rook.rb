require './piece'
require './utils'
require './major_attacking_move'
require './major_move'
class Rook<Piece
  def initialize(piecePosition,alliance,firstMove)
    super(piecePosition,alliance,firstMove)
    @CandidateMoves=Array[-8,-1,1,8]
  end
  def to_s
    'r'
  end
  def calculateLegalMoves(board)
    legalMoves=Array.new
    @CandidateMoves.each do |currentCandidate|
      candidateDestination=@piecePosition
      while(Utils.isValidCoordinate(candidateDestination)&&!isException(candidateDestination,currentCandidate))
        candidateDestination+=currentCandidate
        if (Utils.isValidCoordinate(candidateDestination))
          candidateDestinationTile = board.getTile(candidateDestination)
          if (!candidateDestinationTile.isTileOccupied?)
            legalMoves.push(MajorMove.new(board,self,candidateDestination))
          else
            pieceAtDestination=candidateDestinationTile.getPiece
            pieceAtDestinationAlliance=pieceAtDestination.getPieceAlliance
            if(@pieceAlliance!=pieceAtDestinationAlliance)
              legalMoves.push(MajorAttackingMove.new(board,self,candidateDestination,pieceAtDestination))
            end
            break
          end
        end
      end
    end
    legalMoves
  end
  def isException(currentPosition,candidateMove)
    ((Utils.column?(1,currentPosition) && (candidateMove==-1))   \
    ||(Utils.column?(8,currentPosition) && (candidateMove==1)))
  end
  def isKing?
    false
  end
  def movePiece(move)
    Rook.new(move.getDestination,move.getPiece.getPieceAlliance,false)
  end
  def getValue
    500
  end
  def getBonus
    if(@pieceAlliance==White.new)
      return Utils.whiteRookBonus[@piecePosition]
    else
      return Utils.blackRookBonus[@piecePosition]
    end
  end
end