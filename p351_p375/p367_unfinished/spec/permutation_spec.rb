require './p367'

describe 'Permutation' do
  it 'should return orbit structure [1]' do
    expect(Permutation.new([0]).orbit).to eq Orbit.new([1])
  end

  it 'should return orbit structure [1, 1]' do
    expect(Permutation.new([0, 1]).orbit).to eq Orbit.new([1, 1])
  end

  it 'should return orbit structure [2, 1]' do
    expect(Permutation.new([0, 2, 1]).orbit).to eq Orbit.new([2, 1])
  end
end
