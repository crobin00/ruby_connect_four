# frozen_string_literal: true

require_relative '../lib/board'
require_relative '../lib/player'

describe Board do
  describe '#place_piece' do
    context 'when column has six empty spaces' do
      subject(:empty_board) { described_class.new }

      let(:player_piece) { instance_double(Player, piece: 1) }

      it 'places piece at bottom of col' do
        col = 1
        empty_board.place_piece(player_piece.piece, col)
        board = empty_board.instance_variable_get(:@board)
        board_col = board[1]
        expected_row = [1, nil, nil, nil, nil, nil]
        expect(board_col).to eq(expected_row)
      end
    end

    context 'when column has 3 empty spaces' do
      subject(:half_board) { described_class.new }

      let(:player_piece) { instance_double(Player, piece: 1) }

      before do
        current_board = Array.new(7) { Array.new(6) }
        current_board[1] = [1, 2, 1, nil, nil, nil]
        half_board.instance_variable_set(:@board, current_board)
      end

      it 'places piece in middle of col' do
        col = 1
        half_board.place_piece(player_piece.piece, col)
        board = half_board.instance_variable_get(:@board)
        board_col = board[1]
        expected_row = [1, 2, 1, 1, nil, nil]
        expect(board_col).to eq(expected_row)
      end
    end

    context 'when column has no empty spaces' do
      subject(:half_board) { described_class.new }

      let(:player_piece) { instance_double(Player, piece: 1) }

      before do
        current_board = Array.new(7) { Array.new(6) }
        current_board[1] = [1, 2, 1, 1, 2, 1]
        half_board.instance_variable_set(:@board, current_board)
      end

      it 'does not place piece' do
        col = 1
        half_board.place_piece(player_piece.piece, col)
        board = half_board.instance_variable_get(:@board)
        board_col = board[1]
        expected_row = [1, 2, 1, 1, 2, 1]
        expect(board_col).to eq(expected_row)
      end
    end
  end

  describe '#col_full?' do
    context 'when col is full' do
      subject(:full_board) { described_class.new }

      before do
        current_board = Array.new(7) { Array.new(6) }
        current_board[1] = [1, 2, 1, 1, 2, 1]
        full_board.instance_variable_set(:@board, current_board)
      end

      it 'returns true' do
        col = 1
        return_value = full_board.col_full?(col)
        expect(return_value).to be(true)
      end
    end

    context 'when col is not full' do
      subject(:half_board) { described_class.new }

      before do
        current_board = Array.new(7) { Array.new(6) }
        current_board[1] = [1, 2, 1, 1, nil, nil]
        half_board.instance_variable_set(:@board, current_board)
      end

      it 'returns true' do
        col = 1
        return_value = half_board.col_full?(col)
        expect(return_value).to be(false)
      end
    end
  end

  describe '#check_win_vertically' do
    context 'when won' do
      subject(:won_board) { described_class.new }

      let(:player_piece) { instance_double(Player, piece: 1) }

      before do
        current_board = Array.new(7) { Array.new(6) }
        current_board[1] = [2, 1, 1, 1, 1, nil]
        won_board.instance_variable_set(:@board, current_board)
      end

      it 'returns true' do
        return_value = won_board.check_win_vertically(player_piece)
        expect(return_value).to be(true)
      end
    end

    context 'when won on edge' do
      subject(:won_board) { described_class.new }

      let(:player_piece) { instance_double(Player, piece: 1) }

      before do
        current_board = Array.new(7) { Array.new(6) }
        current_board[1] = [2, 2, 1, 1, 1, 1]
        won_board.instance_variable_set(:@board, current_board)
      end

      it 'returns true' do
        return_value = won_board.check_win_vertically(player_piece)
        expect(return_value).to be(true)
      end
    end

    context 'when not won' do
      subject(:lose_board) { described_class.new }

      let(:player_piece) { instance_double(Player, piece: 1) }

      before do
        current_board = Array.new(7) { Array.new(6) }
        current_board[1] = [2, 2, 2, 1, 1, 1]
        lose_board.instance_variable_set(:@board, current_board)
      end

      it 'returns false' do
        return_value = lose_board.check_win_vertically(player_piece)
        expect(return_value).to be(false)
      end
    end
  end

  describe '#check_win_horizontally' do
    context 'when won' do
      subject(:won_board) { described_class.new }

      let(:player_piece) { instance_double(Player, piece: 1) }

      before do
        current_board = Array.new(7) { Array.new(6) }
        current_board[1] = [2, 1, 1, 2, 2, nil]
        current_board[2] = [2, 2, 1, 1, 2, nil]
        current_board[3] = [2, 1, 1, 1, 1, nil]
        current_board[4] = [2, 2, 1, nil, nil, nil]
        won_board.instance_variable_set(:@board, current_board)
      end

      it 'returns true' do
        return_value = won_board.check_win_horizontally(player_piece)
        expect(return_value).to be(true)
      end
    end

    context 'when won on edge' do
      subject(:won_board) { described_class.new }

      let(:player_piece) { instance_double(Player, piece: 1) }

      before do
        current_board = Array.new(7) { Array.new(6) }
        current_board[3] = [2, 1, 1, 2, 2, nil]
        current_board[4] = [2, 2, 1, 1, 2, nil]
        current_board[5] = [2, 1, 1, 1, 1, nil]
        current_board[6] = [2, 2, 1, nil, nil, nil]
        won_board.instance_variable_set(:@board, current_board)
      end

      it 'returns true' do
        return_value = won_board.check_win_horizontally(player_piece)
        expect(return_value).to be(true)
      end
    end

    context 'when not won' do
      subject(:lose_board) { described_class.new }

      let(:player_piece) { instance_double(Player, piece: 1) }

      before do
        current_board = Array.new(7) { Array.new(6) }
        current_board[1] = [2, 1, 1, 2, 2, 2]
        current_board[2] = [1, 2, 1, 1, 2, 1]
        current_board[3] = [2, 1, 2, 1, 1, 2]
        current_board[4] = [2, 2, 2, 1, 2, 1]
        lose_board.instance_variable_set(:@board, current_board)
      end

      it 'returns false' do
        return_value = lose_board.check_win_vertically(player_piece)
        expect(return_value).to be(false)
      end
    end
  end

  describe '#check_win_diagonally_down' do
    context 'when won' do
      subject(:won_board) { described_class.new }

      let(:player_piece) { instance_double(Player, piece: 1) }

      before do
        current_board = Array.new(7) { Array.new(6) }
        current_board[1] = [1, 1, 1, 2, 2, nil]
        current_board[2] = [2, 1, 1, 1, 2, nil]
        current_board[3] = [2, 1, 1, 1, 1, nil]
        current_board[4] = [2, 2, 2, 1, nil, nil]
        won_board.instance_variable_set(:@board, current_board)
      end

      it 'returns true' do
        return_value = won_board.check_win_diagonally_down(player_piece)
        expect(return_value).to be(true)
      end
    end

    context 'when won on edge' do
      subject(:won_board) { described_class.new }

      let(:player_piece) { instance_double(Player, piece: 1) }

      before do
        current_board = Array.new(7) { Array.new(6) }
        current_board[3] = [1, 1, 1, 2, 2, nil]
        current_board[4] = [2, 1, 1, 1, 2, nil]
        current_board[5] = [2, 1, 1, 1, 1, nil]
        current_board[6] = [2, 2, 2, 2, 2, 1]
        won_board.instance_variable_set(:@board, current_board)
      end

      it 'returns true' do
        return_value = won_board.check_win_diagonally_down(player_piece)
        expect(return_value).to be(true)
      end
    end

    context 'when not won' do
      subject(:lose_board) { described_class.new }

      let(:player_piece) { instance_double(Player, piece: 1) }

      before do
        current_board = Array.new(7) { Array.new(6) }
        current_board[1] = [2, 1, 1, 2, 2, 2]
        current_board[2] = [1, 2, 1, 2, 2, 1]
        current_board[3] = [2, 1, 2, 1, 1, 2]
        current_board[4] = [2, 2, 2, 1, 2, 1]
        lose_board.instance_variable_set(:@board, current_board)
      end

      it 'returns false' do
        return_value = lose_board.check_win_diagonally_down(player_piece)
        expect(return_value).to be(false)
      end
    end
  end

  describe '#check_win_diagonally_up' do
    context 'when won' do
      subject(:won_board) { described_class.new }

      let(:player_piece) { instance_double(Player, piece: 1) }

      before do
        current_board = Array.new(7) { Array.new(6) }
        current_board[1] = [1, 1, 1, 1, 2, nil]
        current_board[2] = [2, 1, 1, 1, 2, nil]
        current_board[3] = [2, 1, 1, 1, 1, nil]
        current_board[4] = [1, 2, 2, 1, nil, nil]
        won_board.instance_variable_set(:@board, current_board)
      end

      it 'returns true' do
        return_value = won_board.check_win_diagonally_up(player_piece)
        expect(return_value).to be(true)
      end
    end

    context 'when won on edge' do
      subject(:won_board) { described_class.new }

      let(:player_piece) { instance_double(Player, piece: 1) }

      before do
        current_board = Array.new(7) { Array.new(6) }
        current_board[0] = [1, 1, 1, 2, 2, 1]
        current_board[1] = [2, 1, 2, 1, 1, nil]
        current_board[2] = [2, 1, 2, 1, 1, nil]
        current_board[3] = [2, 2, 1, 2, 2, 1]
        won_board.instance_variable_set(:@board, current_board)
      end

      it 'returns true' do
        return_value = won_board.check_win_diagonally_up(player_piece)
        expect(return_value).to be(true)
      end
    end

    context 'when not won' do
      subject(:lose_board) { described_class.new }

      let(:player_piece) { instance_double(Player, piece: 1) }

      before do
        current_board = Array.new(7) { Array.new(6) }
        current_board[1] = [2, 1, 1, 2, 2, 2]
        current_board[2] = [1, 2, 1, 2, 2, 1]
        current_board[3] = [2, 1, 2, 1, 1, 2]
        current_board[4] = [2, 2, 2, 1, 2, 1]
        lose_board.instance_variable_set(:@board, current_board)
      end

      it 'returns false' do
        return_value = lose_board.check_win_diagonally_up(player_piece)
        expect(return_value).to be(false)
      end
    end
  end

  describe '#check_draw' do
    context 'when draw' do
      subject(:draw_board) { described_class.new }

      before do
        current_board = Array.new(7) { Array.new(6) }
        current_board[0] = [2, 1, 1, 1, 1, 2]
        current_board[1] = [1, 1, 1, 1, 2, 1]
        current_board[2] = [2, 1, 1, 1, 2, 2]
        current_board[3] = [2, 1, 1, 1, 1, 2]
        current_board[4] = [1, 2, 2, 1, 1, 2]
        current_board[5] = [1, 1, 1, 1, 2, 1]
        current_board[6] = [2, 1, 1, 1, 2, 2]
        draw_board.instance_variable_set(:@board, current_board)
      end

      it 'returns true' do
        return_value = draw_board.check_draw
        expect(return_value).to be(true)
      end
    end

    context 'when not draw' do
      subject(:draw_board) { described_class.new }

      before do
        current_board = Array.new(7) { Array.new(6) }
        current_board[0] = [2, 1, 1, 1, 1, nil]
        current_board[1] = [1, 1, 1, 1, 2, 1]
        current_board[2] = [2, 1, 1, 1, 2, 2]
        current_board[3] = [2, 1, 1, 1, 1, 2]
        current_board[4] = [1, 2, 2, 1, 1, 2]
        current_board[5] = [1, 1, 1, 1, 2, nil]
        current_board[6] = [2, 1, 1, 1, 2, 2]
        draw_board.instance_variable_set(:@board, current_board)
      end

      it 'returns true' do
        return_value = draw_board.check_draw
        expect(return_value).to be(false)
      end
    end
  end
end
