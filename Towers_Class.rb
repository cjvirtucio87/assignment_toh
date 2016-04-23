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

  #Current status of the 'tower' arrays.
  def status
    "#{@towers[:first]}\n#{@towers[:second]}\n#{@towers[:third]}"
  end

  #Display status of the 'tower' arrays.
  def render
    puts self.status
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
