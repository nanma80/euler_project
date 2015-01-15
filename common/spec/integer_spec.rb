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

  it 'should compute modpow' do
    expect(13.mod_pow(0, 7)).to eq ((13 ** 0) % 7)
    expect(3.mod_pow(7, 5)).to eq ((3 ** 7) % 5)
    expect(2.mod_pow(13, 7)).to eq ((2 ** 13) % 7)
  end
end
