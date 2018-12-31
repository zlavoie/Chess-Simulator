require './piece'
require './utils'
require './major_attacking_move'
require './major_move'
class Bishop<Piece
  def initialize(piecePosition,alliance,firstMove)
    super(piecePosition,alliance,firstMove)
    @CandidateMoves=Array[-9,-7,7,9]
  end
  def to_s
    'b'
  end
  def calculateLegalMoves(board)
    legalMoves=Array.new
    @CandidateMoves.each do |currentCandidate|
      candidateDestination=@piecePosition
      while(Utils.isValidCoordinate(candidateDestination) && !isException(candidateDestination,currentCandidate))
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
    ((Utils.column?(1,currentPosition) && (candidateMove==-9||candidateMove==7))   \
    ||(Utils.column?(8,currentPosition) && (candidateMove==-7||candidateMove==9)))
  end
  def isKing?
    false
  end
  def movePiece(move)
    Bishop.new(move.getDestination,move.getPiece.getPieceAlliance,false)
  end
  def getValue
    310
  end
  def getBonus
    if(@pieceAlliance==White.new)
      return Utils.whiteBishopBonus[@piecePosition]
    else
      return Utils.blackBishopBonus[@piecePosition]
    end
  end
end