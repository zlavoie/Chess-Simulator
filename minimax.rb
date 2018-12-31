require './evaluate'
class Minimax
  def execute(board,depth)
    value=0
    bestMove=nil
    highestValue=-Float::INFINITY
    lowestValue=Float::INFINITY
    board.getCurrentPlayer.getLegalMoves.each do |move|
      movedBoard=move.execute
      if(board.getTurn.isWhite)
        value=min(movedBoard,depth-1)
      else
        value=max(movedBoard,depth-1)
      end
      if(board.getTurn.isWhite && value>=highestValue)
        highestValue=value
        bestMove=move
      elsif(board.getTurn.isBlack && value<=lowestValue)
        lowestValue=value
        bestMove=move
      end
    end
    return bestMove
  end

  def min(board,depth)
    eval=Evaluate.new
    if(depth==0 || board.getCurrentPlayer.isGameDone)
      return eval.evaluate(board,depth)
    else
      lowestValue=Float::INFINITY
      board.getCurrentPlayer.getLegalMoves.each do |move|
        currentValue=max(move.execute,depth-1)
        if(currentValue<=lowestValue)
          lowestValue=currentValue
        end
      end
      return lowestValue
    end
  end

  def max(board,depth)
    eval=Evaluate.new
    if(depth==0 || board.getCurrentPlayer.isGameDone)
      return eval.evaluate(board,depth)
    else
      greatestValue=-Float::INFINITY
      board.getCurrentPlayer.getLegalMoves.each do |move|
        currentValue=min(move.execute,depth-1)
        if(currentValue>=greatestValue)
          greatestValue=currentValue
        end
      end
      return greatestValue
    end
  end
end