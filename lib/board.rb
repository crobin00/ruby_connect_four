# frozen_string_literal: true

# Handles board logic
class Board
  attr_reader :board

  def initialize
    @board = Array.new(7) { Array.new(6) }
  end

  def place_piece(piece, col)
    board[col].each_with_index do |row, idx|
      if row.nil?
        board[col][idx] = piece
        break
      end
    end
  end
end
