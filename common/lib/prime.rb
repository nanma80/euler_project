module Prime
  class Cache
    attr_reader :limit

    def initialize(limit)
      @limit = limit
      prime_check
    end

    def prime_check
      return @prime_check unless @prime_check.nil?

      @prime_check = [true] * (limit + 1)
      @prime_check[0] = false
      @prime_check[1] = false
      (2..limit).each do |pointer|
        next unless @prime_check[pointer]
        set_pointer = pointer + pointer
        while set_pointer <= limit
          @prime_check[set_pointer] = false
          set_pointer += pointer
        end
      end
      @prime_check
    end

    def primes
      return @primes unless @primes.nil?

      @primes = []
      each_prime do |prime|
        @primes << prime
      end
      @primes
    end

    def each_prime
      prime_check.each_with_index do |check, index|
        yield index if check
      end
    end

    def is_prime?(key)
      if key < @prime_check.length
        @prime_check[key]
      else
        raise RangeError, "#{key} is not in the cached range from 0 to #{limit}"
      end
    end
  end
end
