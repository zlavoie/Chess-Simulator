require './utils'
class White
  def initialize
    @direction=-1
  end
  def getDirection
    @direction
  end
  def getOppositeDirection
    1
  end
  def ==(alliance)
    @direction == alliance.getDirection
  end
  def isBlack
    false
  end
  def isWhite
    true
  end
  def choosePlayer(whitePlayer,blackPlayer)
    whitePlayer
  end
  def isPromotionSquare?(coordinate)
    (Utils.row(coordinate)==1)
  end
end