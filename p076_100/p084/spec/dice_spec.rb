require './p084'

describe 'Dice' do
  let(:dice_4) { Dice.new(4) }
  let(:dice_6) { Dice.new(6) }

  it 'should compute probabilities' do
    expect(dice_4.probabilities.length).to eq (8 - 2 + 1)
    expect(dice_6.probabilities.length).to eq (12 - 2 + 1)
  end
end

