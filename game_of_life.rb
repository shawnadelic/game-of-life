class Game
    def initialize(size,probability=0.2)
        @board = Array.new
        for i in 0..size-1
            @board.push (Array.new [0] * size)
        end
        @board_size = size
        @probability = probability
    end
    def random_test
        @board.map! do |row|
            row.map! {|col| rand <= @probability ? 1 : col }
        end
    end
    def to_s
        string = ""
        @board.each do |row|
            row.each do |col|
                string += (col == 0 ? "  " : " ϙ" ) 
            end
            string += "\n"
        end
        string
    end
    def run_once
        new_board = Array.new
        for i in 0..@board_size-1
            new_board.push (Array.new [0] * @board_size)
        end
        (0..@board_size-1).each do |i|
            (0..@board_size-1).each do |j|
                new_board[j][i] = will_live(i,j)? 1 : 0
            end
        end
        @board = new_board
    end
    def run
        loop do
            system "clear"
            run_once
            puts "#{to_s}\n"
            sleep 0.1
        end
    end
    private
    def will_live(x,y)
        living = living_neighbors(x,y)
        ( living == 2 and @board[y][x] == 1 ) or living == 3
    end
    def living_neighbors(x,y)
        living = in_bounds(x-1) ? @board[y][x-1] : 0
        living += in_bounds(x+1) ? @board[y][x+1] : 0
        living += in_bounds(y-1) ? @board[y-1][x] : 0
        living += in_bounds(y+1) ? @board[y+1][x] : 0
        living += (in_bounds(x-1) and in_bounds(y-1)) ? @board[y-1][x-1] : 0
        living += (in_bounds(x-1) and in_bounds(y+1)) ? @board[y+1][x-1] : 0
        living += (in_bounds(x+1) and in_bounds(y-1)) ? @board[y-1][x+1] : 0
        living += (in_bounds(x+1) and in_bounds(y+1)) ? @board[y+1][x+1] : 0
    end
    def in_bounds(n)
        (0 <= n) && (n < @board_size)
    end
end

life = Game.new 40, probability = 0.2
life.random_test
puts "#{life}\n"
life.run
