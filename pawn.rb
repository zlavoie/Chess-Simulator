require './piece'
require './utils'
require './pawn_attack_move'
require './pawn_move'
require './pawn_jump'
require './pawn_promotion'
require './en_passant'
require './queen'
require './rook'
require './bishop'
require './knight'
class Pawn<Piece
  def initialize(piecePosition,alliance,firstMove)
    super(piecePosition,alliance,firstMove)
    @CandidateMoves=Array[16,9,8,7]
  end
  def to_s
    'p'
  end
  def calculateLegalMoves(board)
    legalMoves=Array.new
    @CandidateMoves.each do |currentCandidate|
      candidateDestination = @piecePosition + (currentCandidate*@pieceAlliance.getDirection)
      if(Utils.isValidCoordinate(candidateDestination))
        if(currentCandidate==8 && !board.getTile(candidateDestination).isTileOccupied?)
          if(@pieceAlliance.isPromotionSquare?(candidateDestination))
            legalMoves.push(PawnPromotion.new(PawnMove.new(board,self,candidateDestination),Queen.new(candidateDestination,@pieceAlliance,false)))
            legalMoves.push(PawnPromotion.new(PawnMove.new(board,self,candidateDestination),Rook.new(candidateDestination,@pieceAlliance,false)))
            legalMoves.push(PawnPromotion.new(PawnMove.new(board,self,candidateDestination),Bishop.new(candidateDestination,@pieceAlliance,false)))
            legalMoves.push(PawnPromotion.new(PawnMove.new(board,self,candidateDestination),Knight.new(candidateDestination,@pieceAlliance,false)))
          else
            legalMoves.push(PawnMove.new(board,self,candidateDestination))
          end
        elsif(currentCandidate==16 && @isFirstMove)
          blocking=@piecePosition+(8*@pieceAlliance.getDirection)
          if(!board.getTile(blocking).isTileOccupied?()&&!board.getTile(candidateDestination).isTileOccupied?)
            legalMoves.push(PawnJump.new(board,self,candidateDestination))
          end
        elsif((currentCandidate==9||currentCandidate==7)&&!isException(@piecePosition,currentCandidate,@pieceAlliance))
          if(board.getTile(candidateDestination).isTileOccupied?)
            pieceOnCandidate=board.getTile(candidateDestination).getPiece
            if(@pieceAlliance!=pieceOnCandidate.getPieceAlliance)
              if(@pieceAlliance.isPromotionSquare?(candidateDestination))
                legalMoves.push(PawnPromotion.new(PawnAttackMove.new(board,self,candidateDestination,pieceOnCandidate),Queen.new(candidateDestination,@pieceAlliance,false)))
                legalMoves.push(PawnPromotion.new(PawnAttackMove.new(board,self,candidateDestination,pieceOnCandidate),Rook.new(candidateDestination,@pieceAlliance,false)))
                legalMoves.push(PawnPromotion.new(PawnAttackMove.new(board,self,candidateDestination,pieceOnCandidate),Bishop.new(candidateDestination,@pieceAlliance,false)))
                legalMoves.push(PawnPromotion.new(PawnAttackMove.new(board,self,candidateDestination,pieceOnCandidate),Knight.new(candidateDestination,@pieceAlliance,false)))
              else
                legalMoves.push(PawnAttackMove.new(board,self,candidateDestination,pieceOnCandidate))
              end
            end
          elsif(!board.getEnPassantPawn.nil?)
            enPassantPawn=board.getEnPassantPawn
            if(currentCandidate==7)
              if((enPassantPawn.getPiecePosition==(@piecePosition+@pieceAlliance.getOppositeDirection))&&(enPassantPawn.getPieceAlliance!=@pieceAlliance))
                legalMoves.push(EnPassant.new(board,self,candidateDestination,enPassantPawn))
              end
            else
              if((enPassantPawn.getPiecePosition==(@piecePosition+@pieceAlliance.getDirection))&&(enPassantPawn.getPieceAlliance!=@pieceAlliance))
                legalMoves.push(EnPassant.new(board,self,candidateDestination,enPassantPawn))
              end
            end
          end
        end
      end
    end
    legalMoves
  end
  def isException(piecePosition,candidateMove,pieceAlliance)
    ((Utils.column?(1,piecePosition)&&((pieceAlliance.isBlack()&&candidateMove==7)||(pieceAlliance.isWhite()&&candidateMove==9))) \
    ||(Utils.column?(8,piecePosition)&&((pieceAlliance.isBlack()&&candidateMove==9)||(pieceAlliance.isWhite()&&candidateMove==7))))
  end
  def isKing?()
    false
  end
  def movePiece(move)
    Pawn.new(move.getDestination,move.getPiece.getPieceAlliance,false)
  end
  def getValue
    100
  end
  def getBonus
    if(@pieceAlliance==White.new)
      return Utils.whitePawnBonus[@piecePosition]
    else
      return Utils.blackPawnBonus[@piecePosition]
    end
  end
end