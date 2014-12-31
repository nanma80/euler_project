require './p089'

describe 'Convert from Roman to int' do
  let(:conv) {Conv.new}

  it 'should convert 1' do
    expect(conv.to_int('I')).to eq 1
  end

  it 'should do subtraction' do
    expect(conv.to_int('XIX')).to eq 19
  end

  it 'should do multiple subtractions' do
    expect(conv.to_int('MCDIX')).to eq 1409
  end

end

describe 'Convert from int to Roman' do
  let(:conv) {Conv.new}

  it 'should convert 1' do
    expect(conv.to_roman(1)).to eq 'I'
  end

  it 'should convert 3' do
    expect(conv.to_roman(3)).to eq 'III'
  end

  it 'should convert 999' do
    expect(conv.to_roman(999)).to eq 'CMXCIX'
  end

  it 'should convert random number' do
    r = Random.new
    100.times do
      int = r.rand(1..5999)
      roman = conv.to_roman(int)
      # p [int, roman]
      expect(conv.to_int(roman)).to eq int
    end
  end
end