# frozen_string_literal: true

require_relative '../lib/game'
require_relative '../lib/player'

describe Game do
  describe '#player_input' do
    subject(:game_input) { described_class.new }

    context 'when given correct input' do
      it 'returns input' do
        valid_input = '3'
        allow(game_input).to receive(:gets).and_return(valid_input)
        # To use a message expectation, move 'Assert' before 'Act'.
        expect(game_input).not_to receive(:puts).with('Input error!')
        game_input.player_input
      end
    end

    context 'when given one incorrect input then correct input' do
      it 'displays error message once then returns input' do
        invalid_input = '8'
        valid_input = '3'
        allow(game_input).to receive(:gets).and_return(invalid_input, valid_input)
        # To use a message expectation, move 'Assert' before 'Act'.
        expect(game_input).to receive(:puts).with('Input error!').once
        game_input.player_input
      end
    end

    context 'when given two incorrect input then correct input' do
      it 'displays error message twice then returns input' do
        first_invalid = 'd'
        second_invalid = '8'
        valid_input = '3'
        allow(game_input).to receive(:gets).and_return(first_invalid, second_invalid, valid_input)
        # To use a message expectation, move 'Assert' before 'Act'.
        expect(game_input).to receive(:puts).with('Input error!').twice
        game_input.player_input
      end
    end

    context 'when given three incorrect input then quit input' do
      it 'displays error message twice then returns input' do
        first_invalid = 'd'
        second_invalid = '8'
        third_invalid = '-10'
        valid_input = 'q'
        allow(game_input).to receive(:gets).and_return(first_invalid, second_invalid, third_invalid, valid_input)
        # To use a message expectation, move 'Assert' before 'Act'.
        expect(game_input).to receive(:puts).with('Input error!').exactly(3).times
        game_input.player_input
      end
    end
  end

  describe '#check_input' do
    subject(:game_input) { described_class.new }

    context 'when input is 1' do
      it 'returns true' do
        input = '1'
        return_value = game_input.check_input(input)
        expect(return_value).to be(true)
      end
    end

    context 'when input is 7' do
      it 'returns true' do
        input = '7'
        return_value = game_input.check_input(input)
        expect(return_value).to be(true)
      end
    end

    context 'when input is 4' do
      it 'returns true' do
        input = '4'
        return_value = game_input.check_input(input)
        expect(return_value).to be(true)
      end
    end

    context 'when input is 10' do
      it 'returns false' do
        input = '10'
        return_value = game_input.check_input(input)
        expect(return_value).to be(false)
      end
    end

    context 'when input is 1000' do
      it 'returns false' do
        input = '9'
        return_value = game_input.check_input(input)
        expect(return_value).to be(false)
      end
    end

    context 'when input is -1' do
      it 'returns false' do
        input = '-1'
        return_value = game_input.check_input(input)
        expect(return_value).to be(false)
      end
    end

    context 'when input is q to quit' do
      it 'returns true' do
        input = 'q'
        return_value = game_input.check_input(input)
        expect(return_value).to be(true)
      end
    end

    context 'when input is Q to quit' do
      it 'returns true' do
        input = 'Q'
        return_value = game_input.check_input(input)
        expect(return_value).to be(true)
      end
    end
  end

  describe '#switch_turn' do
    subject(:game_turn) { described_class.new }

    let(:player_one) { instance_double(Player, name: 'P1', piece: 1) }
    let(:player_two) { instance_double(Player, name: 'P2', piece: 2) }

    it 'switches players turn' do
      game_turn.instance_variable_set(:@player_one, player_one)
      game_turn.instance_variable_set(:@player_two, player_two)
      game_turn.instance_variable_set(:@current_turn, player_one)
      turn = game_turn.switch_turn
      expect(turn).to eq(player_two)
    end
  end
end
