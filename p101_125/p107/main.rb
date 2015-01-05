testing = false

def filename(testing)
  if testing
    'test_network.txt'
  else
    'p107_network.txt'
  end
end

def matrix(testing)
  output = []
  File.open(filename(testing)).each do |line|
    output << line.chomp.split(',').map {|elem| (elem == '-')?(nil):(elem.to_i)}
  end
  output
end

def total_weight(matrix)
  sum = 0
  (0..matrix.length - 2).each do |from|
    (from + 1..matrix.length - 1).each do |to|
      sum += matrix[from][to] unless matrix[from][to].nil?
    end
  end
  sum
end

def min_tree(matrix)
  node_count = matrix.length
  all_nodes = (0..(node_count - 1)).to_a
  selected_nodes = [0]
  selected_edges = []

  (node_count - 1).times do
    best_edge = nil
    min_edge_weight = nil

    selected_nodes.each do |selected_node|
      all_nodes.each do |not_selected|
        next if selected_nodes.include?(not_selected)
        weight = matrix[selected_node][not_selected]
        next if weight.nil?

        if min_edge_weight.nil? || min_edge_weight > weight
          min_edge_weight = weight
          best_edge = [selected_node, not_selected]
        end
      end
    end

    selected_nodes << best_edge.last
    selected_edges << best_edge
  end

  total_weight = 0
  selected_edges.each do |edge|
    total_weight += matrix[edge.first][edge.last]
  end
  total_weight
end

matrix = matrix(testing)
total_weight = total_weight(matrix)
min_weight = min_tree(matrix)
saving = total_weight - min_weight
p saving
