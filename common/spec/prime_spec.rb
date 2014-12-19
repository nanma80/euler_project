require File.expand_path(File.join('..', '..', 'spec_helper'), __FILE__)

describe 'Prime Cache' do
  before do
    @primes = Prime::Cache.new(10)
    @primes_under_limit = [2, 3, 5, 7]
  end

  it 'should return prime_check' do
    expect(@primes.prime_check.length).to be 11
    expect(@primes.prime_check[1]).to be false
    expect(@primes.prime_check[7]).to be true
  end

  it 'should return primes' do
    expect(@primes.primes).to eq @primes_under_limit
  end

  it 'should yield each prime' do
    primes = []
    @primes.each_prime do |number|
      primes << number
    end
    expect(primes).to eq @primes_under_limit
  end

  it 'should check if a number is prime' do
    expect(@primes.is_prime?(7)).to be true
  end

  it 'should check if a large number is prime' do
    expect { 
      @primes.is_prime?(11)
      }.to raise_error(RangeError)
  end
end