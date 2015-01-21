require './p149'

describe "Matrix" do
  it 'should handle example' do
    test_matrix = [
      [-2, 5, 3, 2],
      [9, -6, 5, 1],
      [3, 2, 7, 3],
      [-1, 8, -4, 8]
    ]

    matrix = Matrix.new(test_matrix)
    expect(matrix.max_sum).to eq 16
  end
end