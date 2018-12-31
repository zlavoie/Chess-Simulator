require './player'
require './king_side_castle'
require './queen_side_castle'
require './black'
class BlackPlayer<Player
  def initialize(board,legalMoves,opponentLegalMoves)
    super(board,legalMoves,opponentLegalMoves)
  end
  def getLivePieces
    @board.getBlackPieces
  end
  def getAlliance
    Black.new
  end
  def getOpponent
    @board.getWhitePlayer
  end
  def calculateCastleMoves(legalMoves,opponentLegalMoves)
    castles=Array.new
    if(@king.getPiecePosition!=-1)
      if((!@board.getTile(5).isTileOccupied?)&&(!@board.getTile(6).isTileOccupied?))
        if(Player.calculateAttacksOnTile(5,opponentLegalMoves).empty? && Player.calculateAttacksOnTile(6,opponentLegalMoves).empty?)
          rookTile=@board.getTile(7)
          if(rookTile.isTileOccupied? && rookTile.getPiece.isFirstMove)
            castles.push(KingSideCastle.new(@board,@king,6,rookTile.getPiece,7,5))
          end
        end
      end
      if((!@board.getTile(1).isTileOccupied?)&&(!@board.getTile(2).isTileOccupied?)&&(!@board.getTile(3).isTileOccupied?))
        if(Player.calculateAttacksOnTile(2,opponentLegalMoves).empty? && Player.calculateAttacksOnTile(3,opponentLegalMoves).empty?)
          rookTile=@board.getTile(0)
          if(rookTile.isTileOccupied? && rookTile.getPiece.isFirstMove)
            castles.push(QueenSideCastle.new(@board,@king,2,rookTile.getPiece,0,3))
          end
        end
      end
    end
    castles
  end
  def to_s
    "Black"
  end

end