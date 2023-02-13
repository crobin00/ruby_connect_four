# frozen_string_literal: true

require_relative '../lib/game'

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
  end
end
