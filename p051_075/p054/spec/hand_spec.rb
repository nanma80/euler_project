require './p054'

describe 'Hand' do
  it 'should initialize a hand' do
    hand = Hand.new('AC TC 5D 7S 9H')
    expect(hand.cards.length).to eq 5
    expect(hand.cards.first.to_s).to eq 'AC'
    expect(hand.cards.last.to_s).to eq '9H'
  end

  it 'should return suits' do
    hand = Hand.new('AC TC 5D 7S 9H')
    expect(hand.suits).to eq [:C, :C, :D, :S, :H]
    expect(hand.flush?).to be false
  end

  it 'should return numerics' do
    hand = Hand.new('AC TC 5D 7S 9H')
    expect(hand.numerics).to eq [14, 10, 5, 7, 9]
  end

  it 'should identify flush' do
    hand = Hand.new('AC 2C 7C 8C QC')
    expect(hand.flush?).to be true
    expect(hand.score).to eq [5, 14, 12, 8, 7, 2]
  end

  it 'should detect straight' do
    expect(Hand.new('5S 3C 2C 4C AC').straight?).to be true
    expect(Hand.new('5S 3C 2C 4C AC').score).to eq [4, 5]

    expect(Hand.new('9C TC QC KC JC').straight?).to be true
    expect(Hand.new('9C TC QC KC JC').score).to eq [8, 13]

    expect(Hand.new('AS KS QC JC TC').straight?).to be true
    expect(Hand.new('AS KS QC JC TC').score).to eq [4, 14]

    expect(Hand.new('AS KS KC JC TC').straight?).to be false
  end

  it 'should detect straight flush' do
    expect(Hand.new('5C 3C 2C 4C AC').straight_flush?).to be true
    expect(Hand.new('5C 3C 2C 4C AC').score).to eq [8, 5]

    expect(Hand.new('9C TC QC KC JC').straight_flush?).to be true
    expect(Hand.new('9C TC QC KC JC').score).to eq [8, 13]

    expect(Hand.new('AS KS QC JC TC').straight_flush?).to be false
    expect(Hand.new('AS KS KC JC TC').straight_flush?).to be false
  end

  it 'should detect royal flush' do
    expect(Hand.new('5C 3C 2C 4C AC').royal_flush?).to be false
    expect(Hand.new('9C TC QC KC JC').royal_flush?).to be false
    expect(Hand.new('AS KS QC JC TC').royal_flush?).to be false

    expect(Hand.new('AS KS QS JS TS').royal_flush?).to be true
    expect(Hand.new('AS KS QS JS TS').score).to eq [9, 14]
  end

  it 'should return numerics histogram' do
    expect(Hand.new('AS KS KC JC TC').numerics_histogram).to eq([[13, 2], [14, 1], [11, 1], [10, 1]])
  end

  it 'should detect pairs' do
    expect(Hand.new('AS KS KC JC TC').pair?).to be true
    expect(Hand.new('AS KS KC JC TC').score).to eq [1, 13, 14, 11, 10]

    expect(Hand.new('AS KS KC JC TC').two_pairs?).to be false
    expect(Hand.new('AS KS KC JC AC').two_pairs?).to be true
    expect(Hand.new('AS KS KC JC AC').score).to eq [2, 14, 13, 11]

    expect(Hand.new('2S KS KC 2H 2C').full_house?).to be true
    expect(Hand.new('2S KS KC 2H 2C').score).to eq [6, 2, 13]

    expect(Hand.new('AS KS 2C AH AC').three?).to be true
    expect(Hand.new('AS KS 2C AH AC').score).to eq [3, 14, 13, 2]

    expect(Hand.new('AS KS AD AH AC').four?).to be true
    expect(Hand.new('AS KS AD AH AC').score).to eq [7, 14, 13]

    expect(Hand.new('AC TC 5D 7S 9H').high_card?).to be true
    expect(Hand.new('AC TC 5D 7S 9H').score).to eq [0, 14, 10, 9, 7, 5]
  end


end
