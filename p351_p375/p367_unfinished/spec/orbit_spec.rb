require './p367'

describe 'Orbit class' do
  it 'should list all orbit structures for 1' do
    expect(Orbit.all(1)).to eq [Orbit.new([1])]
  end

  it 'should list all orbit structures for 2' do
    expect(Orbit.all(2)).to eq [Orbit.new([1, 1]), Orbit.new([2])]
  end

  it 'should list all orbit structures for 3' do
    expect(Orbit.all(3)).to eq [Orbit.new([1, 1, 1]), Orbit.new([2, 1]), Orbit.new([3])]
  end
end

describe 'Orbit' do
  it 'should return a sample permutation for 1' do
    expect(Orbit.new([1]).sample_perm).to eq Permutation.new([0])
  end

  it 'should return a sample permutation for 2' do
    expect(Orbit.new([2]).sample_perm).to eq Permutation.new([1, 0])
  end

  it 'should return a sample perm for 2, 1' do
    expect(Orbit.new([1, 2]).sample_perm).to eq Permutation.new([0, 2, 1])
  end

  it 'should return a sample perm for 3' do
    expect(Orbit.new([3]).sample_perm).to eq Permutation.new([1, 2, 0])
  end
end