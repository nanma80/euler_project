require File.expand_path(File.join('..', '..', 'spec_helper'), __FILE__)

describe 'Integer' do
  it 'should check if is prime' do
    expect(31.is_prime?).to be true
    expect(27.is_prime?).to be false
  end

  it 'should not be prime' do
    expect(1.is_prime?).to be false
    expect(0.is_prime?).to be false
    expect(-1.is_prime?).to be false
  end

  it 'should return factorial' do
    expect((-1).factorial).to eq 0
    expect(0.factorial).to eq 1
    expect(1.factorial).to eq 1
    expect(2.factorial).to eq 2
    expect(3.factorial).to eq 6
    expect(6.factorial).to eq 720
  end

  it 'should compute n choose k' do
    expect(3.choose(5)).to eq 0
    expect(3.choose(0)).to eq 1
    expect(3.choose(1)).to eq 3
    expect(4.choose(2)).to eq 6
  end
end
