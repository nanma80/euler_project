require './p084'

describe 'Monopoly' do
  let(:monopoly) { Monopoly.new }

  it 'should define board' do
    expect(monopoly.board.length).to eq 40
  end

  it 'should find by name' do
    expect(monopoly.index(:go)).to eq 0
    expect(monopoly.code(:go)).to eq '00'
  end

  it 'should find rails and utilities' do
    expect(monopoly.rails.length).to eq 4
    expect(monopoly.utilities.length).to eq 2
  end

  it 'should find next rail' do
    expect(monopoly.next_rail(0)).to eq 5
    expect(monopoly.next_rail(23)).to eq 25
    expect(monopoly.next_rail(36)).to eq 5
  end

  it 'should find next utility' do
    expect(monopoly.next_utility(0)).to eq 12
    expect(monopoly.next_utility(23)).to eq 28
    expect(monopoly.next_utility(35)).to eq 12
  end

  it 'should move' do
    expect(monopoly.move(12, -3)).to eq 9
    expect(monopoly.move(2, -3)).to eq 39
    expect(monopoly.move(38, 11)).to eq 9
  end

  it 'should give probabilities from any start position' do
    dice = Dice.new(6)
    expect(monopoly.transition(1, dice).length).to eq 14
  end

  it 'should go to jail' do
    dice = Dice.new(6)
    go_to_jail = monopoly.transition(25, dice).keys.include?(monopoly.index(:jail))
    expect(go_to_jail).to be true
  end

  it 'should initialize empty matrix' do
    expect(monopoly.zero_matrix(2)).to eq [[0, 0], [0, 0]]
  end

  it 'should generate transition matrix' do
    dice = Dice.new(6)
    # p monopoly.transition_matrix(dice)
    expect(monopoly.transition_matrix(dice).length).to eq 40
  end
end

