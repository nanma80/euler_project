require File.expand_path('../english_number', __FILE__)

describe EnglishNumber do
  it 'should name 1' do
    EnglishNumber.new(1).name.should == 'one'
  end

  it 'should name 6' do
    EnglishNumber.new(6).name.should == 'six'
  end

  it 'should name 12' do
    EnglishNumber.new(12).name.should == 'twelve'
  end

  it 'should name 31' do
    EnglishNumber.new(31).name.should == 'thirty-one'
  end

  it 'should name 50' do
    EnglishNumber.new(50).name.should == 'fifty'
  end

  it 'should name 100' do
    EnglishNumber.new(100).name.should == 'one hundred'
  end

  it 'should name 115' do
    EnglishNumber.new(115).name.should == 'one hundred and fifteen'
  end

  it 'should name 342' do
    EnglishNumber.new(342).name.should == 'three hundred and forty-two'
  end

  it 'should name 1000' do
    EnglishNumber.new(1000).name.should == 'one thousand'
  end

  it 'should count letters for 3' do
    EnglishNumber.new(3).letter_count.should == 5
  end

  it 'should count letters for 115' do
    EnglishNumber.new(115).letter_count.should == 20
  end

  it 'should count letters for 342' do
    EnglishNumber.new(342).letter_count.should == 23
  end

  it 'should count letters for 1000' do
    EnglishNumber.new(1000).letter_count.should == 11
  end
end
