require './utils'
class Black
  def initialize
    @direction=1
  end
  def getDirection
    @direction
  end
  def ==(alliance)
    @direction == alliance.getDirection
  end
  def isBlack
    true
  end
  def getOppositeDirection
    -1
  end
  def isWhite
    false
  end
  def choosePlayer(whitePlayer,blackPlayer)
    blackPlayer
  end
  def isPromotionSquare?(coordinate)
    (Utils.row(coordinate)==8)
  end
end