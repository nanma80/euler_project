require 'benchmark'
require 'set'

class Network
  attr_reader :number_to_group, :group_to_number, :pm_number, :mod

  def initialize(pm_number, mod)
    @mod = mod
    @pm_number = pm_number % mod
    @number_to_group = {}
    @group_to_number = Hash.new { |hash, key| hash[key] = Set.new }
    @new_group_id = 0
    @pm_group_threshold = (@mod * 0.99).to_i
  end

  def each_number(limit)
    buffer = []
    (1..55).each do |k|
      s_k = (100003 - 200003 * k + 300007 * k * k * k) % mod
      buffer << s_k
      yield s_k
    end

    (56..limit).each do |k|
      s_k = (buffer[-55] + buffer[-24]) % mod
      buffer << s_k
      yield s_k
      buffer.delete_at(0)
    end
  end

  def each_call(limit)
    counter = 0
    call_id = 0
    caller = 0
    called = 0
    each_number(2 * limit) do |number|
      counter += 1
      if counter % 2 == 1
        caller = number
      else
        called = number
        call_id += 1
        if caller != called
          yield caller, called
        end
      end
    end
  end

  def populate(limit)
    success_call_count = 0
    old_pm_group_size = 0

    each_call(limit) do |caller, called|
      success_call_count += 1
      if success_call_count % 100000 == 0
        p [success_call_count, @number_to_group.length, @group_to_number.length]
      end

      if @number_to_group[caller].nil? && @number_to_group[called].nil?
        @number_to_group[caller] = @new_group_id
        @number_to_group[called] = @new_group_id
        @group_to_number[@new_group_id] << caller
        @group_to_number[@new_group_id] << called
        @new_group_id += 1
      elsif @number_to_group[caller].nil? || @number_to_group[called].nil?
        # Ensure that caller is visited
        if @number_to_group[caller].nil?
          caller, called = called, caller
        end
        group_id = @number_to_group[caller]
        @number_to_group[called] = group_id
        @group_to_number[group_id] << called
      else
        if @number_to_group[caller] == @number_to_group[called]
          next
        end

        # merge group, user the caller's group
        group_to_keep = @number_to_group[caller]
        group_to_kill = @number_to_group[called]
        if @group_to_number[group_to_keep].length < @group_to_number[group_to_kill].length
          group_to_keep, group_to_kill = group_to_kill, group_to_keep
        end

        # puts "before merge #{@group_to_number[group_to_keep].length}, #{@group_to_number[group_to_kill].length}"
                        
        @group_to_number[group_to_kill].each do |number|
          @number_to_group[number] = group_to_keep
        end

        @group_to_number[group_to_keep].merge(@group_to_number[group_to_kill])
        # @group_to_number[group_to_keep] += (@group_to_number[group_to_kill]) # bad
        @group_to_number.delete(group_to_kill)

        # puts "after merge #{@group_to_number[group_to_keep].length}"
      end

      if not @number_to_group[@pm_number].nil?
        pm_group = @number_to_group[@pm_number]
        pm_group_size = @group_to_number[pm_group].length
        if pm_group_size != old_pm_group_size
          # puts "after #{success_call_count} successful calls, pm group size changes from #{old_pm_group_size} to #{pm_group_size}"
          old_pm_group_size = pm_group_size
        end

        if pm_group_size >= @pm_group_threshold
          puts "after #{success_call_count} successful calls, pm group size: #{pm_group_size}"
          return
        end
      end
    end
  end
end

def main
  mod = 10 ** 6
  # pm_number = 200007
  pm_number = 524287
  # limit = 521 * (10 ** 3)
  limit = 2 * (10 ** 8)
  # limit = 2 * (10 ** 4)
  network = Network.new(pm_number, mod)
  network.populate(limit)
  p network.group_to_number.length

  # network.group_to_number.each do |group, number_set|
  #   if number_set.length > 2
  #     p number_set
  #   end
  # end

  # success_call_count = 0
  # network.each_call(limit) do |caller, called|
  #   success_call_count += 1
  #   if caller == network.pm_number || called == network.pm_number
  #     p success_call_count
  #   end
  # end
end

puts Benchmark.measure { main }