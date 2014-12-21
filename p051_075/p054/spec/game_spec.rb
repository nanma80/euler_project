require './p054'

describe 'Game' do
  it 'should initialize a game' do
    game = Game.new("8C TS KC 9H 4S 7D 2S 5D 3S AC\n")
    hands = game.hands
    expect(hands.length).to eq 2
    expect(hands.first.cards[3].to_s).to eq '9H'
    expect(hands.last.cards[4].to_s).to eq 'AC'
  end
end