class Evaluate
  def evaluate(board,depth)
    (score(board.getWhitePlayer,depth)-score(board.getBlackPlayer,depth))
  end
  def printEval(player,depth)
    puts player
    puts "#{pieceValue(player)} pieceValue, #{mobility(player)} mobility, #{check(player)} check, #{checkMate(player,depth)} checkmate"
    puts "#{castled(player)} castled, #{attacks(player)} attacks"
  end
  def score(player,depth)
    (pieceValue(player)+mobility(player)+check(player)+checkMate(player,depth)+castled(player)+attacks(player))
  end
  def attacks(player)
    attacks=0
    player.getLegalMoves.each do |move|
      if(move.isAttack)
        if(move.getPiece.getValue<=move.getAttackedPiece.getValue)
          attacks+=1
        end
      end
    end
    (10*attacks)
  end
  def kingSafety(player)
    KingSafety.new.evaluate(player)
  end
  def castled(player)
    if(player.getKing.isCastled)
      return 50
    elsif(player.getKing.isFirstMove)
      capable=false
      player.getRooks.each do |rook|
        if(rook.isFirstMove)
          capable=true
        end
      end
      if capable
        return 25
      end
    end
    0
  end
  def checkMate(player,depth)
    if(player.getOpponent.isInCheckMate)
      return 100000-(depth*100)
    end
    0
  end
  def check(player)
    if(player.getOpponent.isInCheck)
      return 50
    end
    0
  end
  def mobility(player)
    2*player.getLegalMoves.length
  end
  def pieceValue(player)
    value=0
    bishops=0
    player.getLivePieces.each do |piece|
      value+=(piece.getValue+piece.getBonus)
      if(piece.to_s=='b')
        bishops+=1
      end
    end
    if(bishops==2)
      value+=50
    end
    value
  end
end