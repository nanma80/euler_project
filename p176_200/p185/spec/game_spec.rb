require './p185'

describe 'Game' do
  attr_reader :game

  before do
    filename = 'test_data.txt'
    @game = Game.new(filename)
  end

  it 'should load clues' do
    expect(game.clues.length).to eq 6
    expect(game.length).to eq 5
  end

  it 'should initialize possibilities' do
    initial_possibilities = game.initial_possibilities
    expect(initial_possibilities.length).to eq 5
    expect(initial_possibilities.first.length).to eq 10
  end

  it 'should filter down to a valid state' do
    possibilities = [[1, 2], [3, 4], [5, 6]]
    clue = Clue.new('136 ;2 correct')
    filter = [true, false, true]
    expect(game.outcome(possibilities, clue, filter)).to eq [[1], [4], [6]]
    expect(possibilities).to eq [[1, 2], [3, 4], [5, 6]]
  end

  it 'should filter down to an invalid state' do
    possibilities = [[1, 2], [3, 4], [5, 6]]
    clue = Clue.new('336 ;2 correct')
    filter = [true, false, true]
    expect(game.outcome(possibilities, clue, filter)).to eq nil
    expect(possibilities).to eq [[1, 2], [3, 4], [5, 6]]
  end

  it 'should filter down to another invalid state' do
    possibilities = [[1, 2], [3], [5, 6]]
    clue = Clue.new('236 ;2 correct')
    filter = [true, false, true]
    expect(game.outcome(possibilities, clue, filter)).to eq nil
    expect(possibilities).to eq [[1, 2], [3], [5, 6]]
  end

  it 'should solve' do
    expect(game.solve).to eq '39542'
  end

  it 'should check' do
    expect(game.check([3, 9, 5, 4, 2])).to be true
    expect(game.check([7, 9, 5, 4, 2])).to be false
    expect(game.check([3, 9, 5, 3, 2])).to be false
  end
end
