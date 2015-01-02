require 'set'

def operate(a, b, operation_id)
  log = false

  case operation_id
  when 0
    puts "#{a} + #{b}" if log
    a + b
  when 1
    puts "#{a} - #{b}" if log
    a - b
  when 2
    puts "#{a} * #{b}" if log
    a * b
  when 3
    puts "#{a} / #{b}" if log
    if b == 0
      raise ZeroDivisionError, "#{a} / #{b}"
    end
    1.0 * a / b
  else
    raise "Unexpected operation_id: #{operation_id}"
  end
end

def evaluate(array, positions, operations)
  a = array.dup
  begin
    a << operate(a.delete_at(positions[0]), a.delete_at(positions[1]), operations[0])
    a << operate(a.delete_at(positions[2]), a.delete_at(positions[3]), operations[1])
    a << operate(a.delete_at(positions[4]), a.delete_at(0), operations[2])
  rescue ZeroDivisionError
    return nil
  end
  output = a.first
  if output > 0 && output == output.to_i
    output.to_i
  else
    nil
  end
end

def each_positions
  modulos = [4, 3, 3, 2, 2]
  each(modulos) do |positions|
    yield positions
  end
end

def each_operations
  modulos = [4, 4, 4]
  each(modulos) do |operations|
    yield operations
  end
end

def each(modulos)
  (0..(modulos.inject(:*) - 1)).each do |gen|
    output = []
    modulos.each do |modulo|
      output << (gen % modulo)
      gen /= modulo
    end
    yield output
  end
end

def targets(array)
  targets = Set.new
  each_positions do |positions|
    each_operations do |operations|
      target = evaluate(array, positions, operations)
      unless target.nil?
        targets << target
      end
    end
  end
  targets.sort
end

def consecutive_integers(array)
  targets = targets(array)
  largest = 0
  targets.each_with_index do |target, index|
    if target == index + 1
      largest = target
    else
      return largest
    end
  end
  largest
end

greatest_value = 0
greatest_array = nil
(1..9).each do |a|
  ((a + 1)..9).each do |b|
    ((b + 1)..9).each do |c|
      ((c + 1)..9).each do |d|
        array = [a, b, c, d]
        value = consecutive_integers(array)
        if value > greatest_value
          greatest_value = value
          greatest_array = array
        end
      end
    end
  end
end

puts greatest_array.map(&:to_s).join
