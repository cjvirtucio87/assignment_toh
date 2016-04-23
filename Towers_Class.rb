class Towers
  #Getters and setters.
  attr_accessor :player, :difficulty, :disc_num, :towers, :win

  #Constructor.
  def initialize
    @difficulty_settings = {easy: 3, medium: 5, hard: 7}
  end

  def set_player_name(player_name)
    @player = player_name
  end

  def set_difficulty(difficulty)
    @difficulty = difficulty
  end



  #Creating the 'tower' arrays based on the selected difficulty.
  def build_towers
    puts "Building towers.."
    sleep 1.5
    @disc_num = @difficulty_settings[@difficulty]
    @towers = {first: (1..@disc_num).sort{|num1,num2| num2 <=> num1},\
              second: [], third: []}
  end

  #Get disc sizes.
  def get_disc_sizes
    @disc_sizes = []
    i = 0
    while @disc_sizes.length < @disc_num
      @disc_sizes[i] = (i+1) + i
      i += 1
    end
    @disc_sizes
  end

  #Get space count per level.
  def get_space_count
    @space_count = []
    i = 0
    while @space_count.length < @disc_num
      @space_count[i] = (@disc_num-1) - i
      i += 1
    end
    @space_count
  end

  #Make discs using disc sizes.
  def make_discs
    @discs = []
    @disc_sizes.each do |size|
      disc = ''
      size.times do
        disc << '#'
      end
      @discs << disc
    end
    @discs
  end

  #Make spaces using space count.
  def make_spaces
    @spaces = []
    @space_count.each do |count|
      space = ''
      count.times do
        space << ' '
      end
      @spaces << space
    end
    @spaces
  end

  #Display status of the 'tower' arrays.
  def render
    visual = []
    @discs.each_index do |idx|
      visual << "#{@spaces[idx]}#{@discs[idx]}"
    end
    puts visual
  end

  #Moving a disc from a tower.
  def move_disc(source,destination)
    @towers[destination] << @towers[source].pop
  end

  #Checking if the player has won or lost.
  def win?
    @win = !!(@towers[:third] == (1..@disc_num).sort\
        {|num1,num2| num2 <=> num1})
  end

  #Checking if the player is attempting to quit the game.
  def quit?(input)
    abort if !!(/quit/i.match(input))
  end
end
