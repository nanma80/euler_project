require './p128'

describe 'Board' do
  let (:board) { Board.new(37) }
  
  it 'initialize' do
    expect(board.limit).to eq 37
    expect(board.board.length).to eq 37
  end

  it 'should return next direction' do
    expect(board.next_direction([0, -1])).to eq [1, 0]
  end

  it 'should yield coordinates' do
    coordinates = []
    board.each_coordinates do |coord|
      coordinates << coord
    end
    expect(coordinates.length).to eq 37
    expect(coordinates.last).to eq [1, 3]
  end

  it 'should find neighbors' do
    expected_neighbors = [1, 5, 15, 16, 17, 7]
    expect(board.neighbors(6).sort).to eq expected_neighbors.sort
  end

  it 'should find neighbor diffs' do
    expected_diffs = [12, 29, 11, 6, 1, 13]
    expect(board.neighbor_diffs(8).sort).to eq expected_diffs.sort
  end

  it 'should count prime diffs' do
    expect(board.prime_count(8)).to eq 3
    expect(board.prime_count(17)).to eq 2
  end
end