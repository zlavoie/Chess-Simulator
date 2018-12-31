require './utils'
class Player
  def initialize(board,legalMoves,opponentLegalMoves)
    @board=board
    @king=findKing
    @rooks=findRooks
    @castleMoves=calculateCastleMoves(legalMoves,opponentLegalMoves)
    @legalMoves=legalMoves+@castleMoves
    @OpponentLegalMoves=opponentLegalMoves
    @isInCheck=!Player.calculateAttacksOnTile(@king.getPiecePosition,@OpponentLegalMoves).empty?

  end
  def self.calculateAttacksOnTile(position,opponentMoves)
    moves=Array.new
    opponentMoves.each do |move|
      if(position==move.getDestination)
        moves.push(move)
      end
    end
    moves
  end
  def filterMoves(legalMoves)
    trueLegalMoves=Array.new
    legalMoves.each do |move|
      transitionBoard=move.execute
      if(transitionBoard.getCurrentPlayer.getOpponent.getKing.getPiecePosition!=-1)
        if(Player.calculateAttacksOnTile(transitionBoard.getCurrentPlayer.getOpponent.getKing.getPiecePosition, \
                                         transitionBoard.getCurrentPlayer.getMoves).empty?)
          trueLegalMoves.push(move)
        end
      end
    end
    trueLegalMoves
  end
  def getMoves
    @legalMoves
  end
  def findKing
    getLivePieces.each do |piece|
      if(piece.isKing?())
        return piece
      end
    end
    King.new(-1,nil,false,false)
  end
  def findRooks
    rooks=Array.new
    getLivePieces.each do |piece|
      if(piece.to_s=='r')
        rooks.push(piece)
      end
    end
  end
  def getRooks
    @rooks
  end
  def getKing
    @king
  end
  def getLegalMoves
    filterMoves(@legalMoves)
  end
  def isLegalMove(move)
    @legalMoves.include? move
  end
  def isInCheck
    @isInCheck
  end
  def isInCheckMate
    (@isInCheck && !hasMoves)
  end
  def hasMoves
    @legalMoves=filterMoves(@legalMoves)
    (!@legalMoves.empty?)
  end
  def isInStaleMate
    (!@isInCheck && !hasMoves)
  end
  def isCastled
  end
  def printMoves(string)
    @legalMoves=filterMoves(@legalMoves)
    count=0
    c=0
    @legalMoves.each do |move|
      if(Utils.coordinateToString(move.getPiece.getPiecePosition)==string)
        print "#{move}, "
        count+=1
        c+=1
        if(c==15)
          print "\n"
          c=0
        end
      end
    end
    if(count==0)
      puts "No moves from square #{string}"
    else
      print "\n"
    end
  end
  def printLegalMoves
    c=0
    @legalMoves=filterMoves(@legalMoves)
    @legalMoves.each do |move|
      print "#{move}, "
      c+=1
      if(c==15)
        print "\n"
        c=0
      end
    end
    print "\n"
  end
  def makeMove(move)
    @legalMoves=filterMoves(@legalMoves)
    if(isLegalMove(move))
      return move.execute
    end
  end
  def move(string)
    @legalMoves=filterMoves(@legalMoves)
    @legalMoves.each do |move|
      if(move.to_s==string)
        return makeMove(move)
      end
    end
    "Invalid Move"
  end
  def isGameDone
    (isInCheckMate||isTables)
  end
  def isTables
    (isInStaleMate||deadPosition)
  end
  def deadPosition
    whitePieces=@board.getWhitePieces
    blackPieces=@board.getBlackPieces
    if(whitePieces.length==1 and blackPieces.length==1)
      return true
    elsif(whitePieces.length==2 and blackPieces.length==1)
      whitePieces.each do |piece|
        if(piece.to_s=="b" || piece.to_s=='n')
          return true
        end
      end
    elsif(whitePieces.length==1 and blackPieces.length==2)
      blackPieces.each do |piece|
        if(piece.to_s=="b" || piece.to_s=='n')
          return true
        end
      end
    elsif(whitePieces.length==2 and blackPieces.length==2)
      bishop1='none'
      bishop2='none'
      blackPieces.each do |piece|
        if(piece.to_s=="b")
          if((Utils.row(piece.getPiecePosition)%2)==(piece.getPiecePosition%2))
            bishop1='black'
          else
            bishop1='white'
          end
        end
      end
      whitePieces.each do |piece|
        if(piece.to_s=="b")
          if((Utils.row(piece.getPiecePosition)%2)==(piece.getPiecePosition%2))
            bishop2='black'
          else
            bishop2='white'
          end
        end
      end
      if(bishop1==bishop2 && bishop1!='none')
        return true
      end
    end
    false
  end
end