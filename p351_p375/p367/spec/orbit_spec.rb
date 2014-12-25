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

  it 'should group neighbors' do
    orbit = Orbit.new([1, 1, 1])

    perm = double(:permutation)
    perm.stub(:neighbors).and_return([Permutation.new([1, 0, 2]), Permutation.new([0, 2, 1]), Permutation.new([1, 2, 0])])
    
    orbit.stub(:sample_perm).and_return(perm)

    expect(orbit.neighbors).to eq({[3] => 1, [2, 1] => 2})
  end

  it 'should return weight for 1' do
    expect(Orbit.new([1]).weight).to eq 1
  end

  it 'should return weight for 2' do
    expect(Orbit.new([2]).weight).to eq 1
  end

  it 'should return weight for 2, 1' do
    expect(Orbit.new([2, 1]).weight).to eq 3
  end

  it 'should return weight for 1, 1, 1, 1' do
    expect(Orbit.new([1, 1, 1, 1]).weight).to eq 1
  end

  it 'should return weight for 2, 1, 1' do
    expect(Orbit.new([2, 1, 1]).weight).to eq 6
  end

  it 'should return weight for 3, 1' do
    expect(Orbit.new([3, 1]).weight).to eq 8
  end

  it 'should return weight for 4' do
    expect(Orbit.new([4]).weight).to eq 6
  end

  it 'should return weight for 2, 2' do
    expect(Orbit.new([2, 2]).weight).to eq 3
  end

  it 'should sanity check weight for 6' do
    weight_sum = 0
    Orbit.all(6).each do |orbit|
      weight_sum += orbit.weight
    end
    expect(weight_sum).to eq 6.factorial
  end
end