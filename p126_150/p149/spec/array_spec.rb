require './p149'

describe "Array max sum" do
  it 'should handle empty array' do
    expect([].max_sum).to eq 0
  end

  it 'should handle simple case' do
    expect([1, 2, 1].max_sum).to eq 4
  end

  it 'should handle negative' do
    expect([1, 2, -10].max_sum).to eq 3
  end

  it 'should handle broken sequence' do
    expect([1, 2, -10, 2, 3].max_sum).to eq 5
  end
end