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

  def col_full?(col)
    return true unless board[col].last.nil?

    false
  end

  def check_win(player)
    return true if check_win_vertically(player) ||
                   check_win_horizontally(player) ||
                   check_win_diagonally_down(player) ||
                   check_win_diagonally_up(player)

    false
  end

  def check_win_vertically(player)
    board.each_with_index do |_col, col_idx|
      3.times do |space|
        return true if board[col_idx][space] == player.piece &&
                       board[col_idx][space + 1] == player.piece &&
                       board[col_idx][space + 2] == player.piece &&
                       board[col_idx][space + 3] == player.piece
      end
    end
    false
  end

  def check_win_horizontally(player)
    (0..6).each_with_index do |_row, row_idx|
      4.times do |space|
        return true if board[space][row_idx] == player.piece &&
                       board[space + 1][row_idx] == player.piece &&
                       board[space + 2][row_idx] == player.piece &&
                       board[space + 3][row_idx] == player.piece
      end
    end
    false
  end

  def check_win_diagonally_down(player)
    4.times do |col|
      3.times do |row|
        return true if board[col][row] == player.piece &&
                       board[col + 1][row + 1] == player.piece &&
                       board[col + 2][row + 2] == player.piece &&
                       board[col + 3][row + 3] == player.piece
      end
    end
    false
  end

  def check_win_diagonally_up(player)
    (3..6).to_a.reverse.each do |col|
      3.times do |row|
        return true if board[col][row] == player.piece &&
                       board[col - 1][row + 1] == player.piece &&
                       board[col - 2][row + 2] == player.piece &&
                       board[col - 3][row + 3] == player.piece
      end
    end
    false
  end

  def display
    output = ''
    output += " 1 | 2 | 3 | 4 | 5 | 6 | 7 \n"
    (0..5).reverse_each do |row|
      7.times do |col|
        output += ' '
        output += 'O' if board[col][row] == 1
        output += 'X' if board[col][row] == 2
        output += ' ' if board[col][row].nil?
        output += ' |'
      end
      output += "\n"
      output += '---------------------------'
      output += "\n"
    end
    output
  end
end
