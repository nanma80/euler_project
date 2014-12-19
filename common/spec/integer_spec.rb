require File.expand_path(File.join('..', '..', 'spec_helper'), __FILE__)

describe 'Integer' do
  it 'should check if is prime' do
    expect(31.is_prime?).to be true
    expect(27.is_prime?).to be false
  end
end
