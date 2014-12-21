require './p054'

describe 'Card' do
  it 'should initialize a card' do
    card = Card.new('AC')
    expect(card.value).to eq :A
    expect(card.suit).to eq :C
    expect(card.input_string).to eq 'AC'
  end

  it 'should return numeric value' do
    card_a = Card.new('AC')
    expect(card_a.numeric).to eq 14

    card_7 = Card.new('7D')
    expect(card_7.numeric).to eq 7

    card_q = Card.new('QC')
    expect(card_q.numeric).to eq 12
  end
end
