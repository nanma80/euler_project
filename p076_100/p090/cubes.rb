class Cubes
  attr_reader :code

  def initialize(code)
    @code = code
  end

  def targets
    @targets ||= (1..9).to_a.map {|n| "%.2d" % (n * n)}.map{|s| s.gsub('9', '6')}
  end

  def assignments
    @assignments ||= (code + 2**(targets.length)).to_s(2)[1..-1].split('').map(&:to_i)
  end

  def cubes
    return @cubes unless @cubes.nil?
    @cubes = [[], []]
    assignments.each_with_index do |assignment, index|
      target = targets[index]
      @cubes[assignment] << target[0].to_i
      @cubes[1 - assignment] << target[1].to_i
    end
    @cubes.each do |cube|
      cube.uniq!.sort!
    end
    @cubes
  end

  def cube_lengths
    cubes.map(&:length)
  end
end