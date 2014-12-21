require './p054'

describe 'Hand' do
  it 'should initialize a hand' do
    hand = Hand.new('AC TC 5D 7S 9H')
    expect(hand.cards.length).to eq 5
    expect(hand.cards.first.to_s).to eq 'AC'
    expect(hand.cards.last.to_s).to eq '9H'
  end
end
