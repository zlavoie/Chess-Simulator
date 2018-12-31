require './move'
class MajorMove<Move
  def initialize(board,movedPiece,destination)
    super(board,movedPiece,destination)
  end
  def ==(move)
    if(move.instance_of? MajorMove)
      return (@movedPiece==move.getPiece && @destination==move.getDestination)
    end
    false
  end
  def to_s
    "#{@movedPiece.to_s.upcase}#{disambiguation}#{Utils.coordinateToString(@destination)}"
  end
end