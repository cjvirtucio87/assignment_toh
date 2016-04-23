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
    puts "\nBuilding towers.."
    sleep 1.5
    @disc_num = @difficulty_settings[@difficulty]
    @towers = {first: (self.get_disc_sizes).sort{|num1,num2| num2 <=> num1},\
              second: [], third: []}
  end

  #Get disc sizes.
  def get_disc_sizes
    @disc_sizes = []
    i = @disc_num-1
    j = 0
    while j < @disc_num
      @disc_sizes[j] = (i+1) + i
      i -= 1
      j += 1
    end
    @disc_sizes
  end

  #Get space count per level.
  def get_space_count (tower)
    @space_count = []
    i = @towers[tower].length-1
    j = 0
    while j < @towers[tower].length
      @space_count[j] = i
      i -= 1
      j += 1
    end
    @space_count
  end

  #Make discs using disc sizes.
  def make_discs (tower)
    @discs = []
    @towers[tower].reverse_each do |size|
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

  def make_visuals (tower)
    visuals = []
    i = 0
    while i < @towers[tower].length
      visuals << "#{@spaces[i]}#{@discs[i]}"
      i += 1
    end
    visuals
  end

  #Display status of the 'tower' arrays.
  def render
    output = []
    @towers.keys.each do |tower|
      self.get_space_count(tower)
      self.make_discs(tower)
      self.make_spaces
      output << "\n[#{tower.upcase}]:\n"
      output << make_visuals(tower)
      output << "\n"
    end
    puts output
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
