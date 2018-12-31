require './board'
require './minimax'
require './evaluate'
class Chess
  board=Board.new
  board.createStandardBoard
  board.build
  puts "1 or 2 players?"
  choice=gets
  choice=choice.chomp
  puts "Use Standard Algebraic Notation"
  if(choice=='1')
    eval=Evaluate.new
    mini=Minimax.new
    puts board
    player=board.getCurrentPlayer
    while(!player.isGameDone)
      puts "#{player} Enter move,? to see moves, or ? and square to see moves from square"
      input=gets
      input=input.chomp
      if(input=='?')
        player.printLegalMoves
      elsif(input.start_with?('?'))
        player.printMoves(input[1..-1])
      else
        res=player.move(input)
        if(res.is_a?(Board))
          board=res
          player=board.getCurrentPlayer
          puts board
          #eval.printEval(player,0)
          #eval.printEval(player.getOpponent,0)
          if(!player.isGameDone)
            compMove=mini.execute(board,1)
            board=player.makeMove(compMove)
            player=board.getCurrentPlayer
            puts "Computer played #{compMove}"
            puts board
            #eval.printEval(player,0)
            #eval.printEval(player.getOpponent,0)
          end
        else
          puts res
        end
      end
    end
    if player.isInCheckMate
      puts "Checkmate! #{player.getOpponent} wins!"
    elsif player.isInStaleMate
      puts "Draw! #{player} is in Stalemate"
    else
      puts "Draw! insufficient material! "
    end
  else
    puts board
    player=board.getCurrentPlayer
    while(!player.isGameDone)
      puts "#{player} Enter move,? to see moves, or ? and square to see moves from square"
      input=gets
      input=input.chomp
      if(input=='?')
        player.printLegalMoves
      elsif(input.start_with?('?'))
        player.printMoves(input[1..-1])
      else
        res=player.move(input)
        if(res.is_a?(Board))
          board=res
          player=board.getCurrentPlayer
          puts board
        else
          puts res
        end
      end
    end
    if player.isInCheckMate
      puts "Checkmate! #{player.getOpponent} wins!"
    elsif player.isInStaleMate
      puts "Draw! #{player} is in Stalemate"
    else
      puts "Draw! insufficient material! "
    end
  end
end