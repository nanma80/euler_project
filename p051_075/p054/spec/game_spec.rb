require './p054'

describe 'Game' do
  it 'should initialize a game' do
    game = Game.new("8C TS KC 9H 4S 7D 2S 5D 3S AC")
    hands = game.hands
    expect(hands.length).to eq 2
    expect(hands.first.cards[3].to_s).to eq '9H'
    expect(hands.last.cards[4].to_s).to eq 'AC'
  end

  it 'should compute scores' do
    game = Game.new("8C TS KC 9H 4S 7D 2S 5D 3S AC")
    expect(game.scores.length).to eq 2
  end

  it 'should determine winner case 1' do
    game = Game.new("5H 5C 6S 7S KD 2C 3S 8S 8D TD")
    expect(game.player_1_wins?).to be false
  end

  it 'should determine winner case 2' do
    game = Game.new("5D 8C 9S JS AC 2C 5C 7D 8S QH")
    expect(game.player_1_wins?).to be true
  end

  it 'should determine winner case 3' do
    game = Game.new("2D 9C AS AH AC 3D 6D 7D TD QD")
    expect(game.player_1_wins?).to be false
  end

  it 'should determine winner case 4' do
    game = Game.new("4D 6S 9H QH QC 3D 6D 7H QD QS")
    expect(game.player_1_wins?).to be true
  end

  it 'should determine winner case 5' do
    game = Game.new("2H 2D 4C 4D 4S 3C 3D 3S 9S 9D")
    expect(game.player_1_wins?).to be true
  end

end