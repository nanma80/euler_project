require './p185'

describe 'Clue' do
  attr_reader :clue

  before do
    @clue = Clue.new('90342 ;2 correct')
  end

  it 'should load clue' do
    expect(clue.correct).to eq 2
    expect(clue.guess).to eq [9, 0, 3, 4, 2]
    expect(clue.length).to eq 5
  end

  it 'should iterate over possible filters' do
    filters = []
    clue.each_filter do |filter|
      filters << filter
    end
    expect(filters[0]).to eq [true, true, false, false, false]
    expect(filters.length).to eq (5 * 4 / 2)
  end
end