require './white'
require './player'
require './king_side_castle'
require './queen_side_castle'
class WhitePlayer<Player
  def initialize(board,legalMoves,opponentLegalMoves)
    super(board,legalMoves,opponentLegalMoves)
  end
  def getLivePieces
    @board.getWhitePieces
  end
  def getAlliance
    White.new
  end
  def getOpponent
    @board.getBlackPlayer
  end
  def calculateCastleMoves(legalMoves,opponentLegalMoves)
    castles=Array.new
    if(@king.getPiecePosition!=-1)
      if(@king.isFirstMove && !@isInCheck)
        if((!@board.getTile(61).isTileOccupied?)&&(!@board.getTile(62).isTileOccupied?))
          if(Player.calculateAttacksOnTile(61,opponentLegalMoves).empty? && Player.calculateAttacksOnTile(62,opponentLegalMoves).empty?)
            rookTile=@board.getTile(63)
            if(rookTile.isTileOccupied? && rookTile.getPiece.isFirstMove)
              castles.push(KingSideCastle.new(@board,@king,62,rookTile.getPiece,63,61))
            end
          end
        end
        if((!@board.getTile(59).isTileOccupied?)&&(!@board.getTile(58).isTileOccupied?)&&(!@board.getTile(57).isTileOccupied?))
          if(Player.calculateAttacksOnTile(59,opponentLegalMoves).empty? && Player.calculateAttacksOnTile(58,opponentLegalMoves).empty?)
            rookTile=@board.getTile(56)
            if(rookTile.isTileOccupied? && rookTile.getPiece.isFirstMove)
              castles.push(QueenSideCastle.new(@board,@king,58,rookTile.getPiece,56,59))
            end
          end
        end
      end
    end
    castles
  end
  def to_s
    "White"
  end
end
