class Loader
  DATA_FILE = 'p096_sudoku.txt'

  class << self
    def execute(options = {})
      grids = []
      buffer = LoaderBuffer.new

      File.open(DATA_FILE) do |f|
        f.each_line do |line|
          line.chomp!
          buffer << line

          if buffer.full?
            grids << buffer.grid
            buffer = LoaderBuffer.new
            
            return grids if options[:testing]
          end
        end
      end

      grids
    end
  end
end
