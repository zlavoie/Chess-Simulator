require './bishop'
require './king'
require './knight'
require './pawn'
require './queen'
require './rook'
require './white_player'
require './black_player'
require './black'
require './white'
require './tile'
class Board
  def initialize
    @boardConfig=Array.new
    @enPassantPawn=nil
  end
  def getCurrentPlayer
    @currentPlayer
  end
  def build
    @gameBoard=createGameBoard
    @whitePieces=getLivePieces(White.new)
    @blackPieces=getLivePieces(Black.new)
    @whiteLegalMoves=getLegalMoves(@whitePieces)
    @blackLegalMoves=getLegalMoves(@blackPieces)
    @whitePlayer=WhitePlayer.new(self,@whiteLegalMoves,@blackLegalMoves)
    @blackPlayer=BlackPlayer.new(self,@blackLegalMoves,@whiteLegalMoves)
    @currentPlayer=@turn.choosePlayer(@whitePlayer,@blackPlayer)
  end
  def getCurrentPlayer
    @currentPlayer
  end
  def to_s
    board=""
    for i in 0..63
      if(i%8==0)
        board+="#{-(i/8)+8}  "
      end
      if(@gameBoard[i].isTileOccupied?)
        p=@gameBoard[i].getPiece.to_s
        if @gameBoard[i].getPiece.getPieceAlliance==White.new
          board+=" #{p.upcase} "
        else
          board+= " #{p} "
        end
      else
        board+= " - "
      end
      if (i%8==7)
        board+= "\n"
      end
    end
    board+="\n"
    board+= "    a  b  c  d  e  f  g  h"
    board
  end
  def getWhitePieces
    @whitePieces
  end
  def getBlackPieces
    @blackPieces
  end
  def getWhitePlayer
    @whitePlayer
  end
  def getBlackPlayer
    @blackPlayer
  end
  def getLegalMoves(pieces)
    legalMoves=Array.new
    pieces.each do |piece|
      legalMoves+=piece.calculateLegalMoves(self)
    end
    legalMoves
  end
  def getLivePieces(alliance)
    livePieces=Array.new
    for i in 0..63
      if @gameBoard[i].isTileOccupied?
        piece=@gameBoard[i].getPiece
        if(piece.getPieceAlliance==alliance)
          livePieces.push(piece)
        end
      end
    end
    livePieces
  end
  def createGameBoard
    tiles=Array.new
    for i in 0..63
      tiles[i]=Tile.createTile(i,@boardConfig[i])
    end
    tiles
  end
  def createStandardBoard
    setPiece(Rook.new(0,Black.new(),true))
    setPiece(Knight.new(1,Black.new(),true))
    setPiece(Bishop.new(2,Black.new(),true))
    setPiece(Queen.new(3,Black.new(),true))
    setPiece(King.new(4,Black.new(),true,false))
    setPiece(Bishop.new(5,Black.new(),true))
    setPiece(Knight.new(6,Black.new(),true))
    setPiece(Rook.new(7,Black.new(),true))
    for i in 8..15
      setPiece(Pawn.new(i,Black.new(),true))
    end
    for i in 48..55
      setPiece(Pawn.new(i,White.new(),true))
    end
    setPiece(Rook.new(56,White.new(),true))
    setPiece(Knight.new(57,White.new(),true))
    setPiece(Bishop.new(58,White.new(),true))
    setPiece(Queen.new(59,White.new(),true))
    setPiece(King.new(60,White.new(),true,false))
    setPiece(Bishop.new(61,White.new(),true))
    setPiece(Knight.new(62,White.new(),true))
    setPiece(Rook.new(63,White.new(),true))
    setTurn(White.new)
  end
  def setPiece(piece)
    @boardConfig[piece.getPiecePosition]=piece
  end
  def getTile(coordinate)
    @gameBoard[coordinate]
  end
  def getAllLegalMoves
    moves=Array.new
    moves=@whiteLegalMoves+@blackLegalMoves
    moves
  end
  def setTurn(alliance)
    @turn=alliance
  end
  def getTurn
    @turn
  end
  def setEnPassantPawn(pawn)
    @enPassantPawn=pawn
  end
  def getEnPassantPawn
    @enPassantPawn
  end
end