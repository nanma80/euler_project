require './p128'

describe 'FastBoard' do
  let (:board) { FastBoard.new(60) }
  
  it 'initialize' do
    expect(board.limit).to eq 60
  end

  it 'should test all primes' do
    expect(board.all_prime?([3, 4, 7])).to be false
    expect(board.all_prime?([3, 7, 11])).to be true
  end

  it 'should compute the initial values' do
    expected_numbers = [1, 2, 8, 19, 20, 37, 61, 128, 217, 271, 398, 919, 1519, 1520, 2978, 3170, 4220, 4447, 4681, 5677, 5941, 6488, 8269]
    length = expected_numbers.length
    values = board.values
    expect(values[0..length - 1]).to eq expected_numbers
  end

  it 'should return neighbor diffs for start of layer' do
    value1, diffs1 = board.neighbors_start_of_layer(1)
    expect(value1).to eq 2
    expect(diffs1).to eq [5, 7, 17]

    value2, diffs2 = board.neighbors_start_of_layer(2)
    expect(value2).to eq 8
    expect(diffs2).to eq [11, 13, 29]

    value3, diffs3 = board.neighbors_start_of_layer(3)
    expect(value3).to eq 20
  end

  it 'should return neighbor diffs for end of layer' do
    value2, diffs2 = board.neighbors_end_of_layer(2)
    expect(value2).to eq 19
    expect(diffs2).to eq [19 - 8, 36 - 19, 19 - 2]
  end
end