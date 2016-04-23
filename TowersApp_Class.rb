class TowersApp
  attr_accessor :player_name, :app_difficulty, :source_tower, :destination_tower

  def initialize(target_object)
    @target = target_object
    @messages = []
    puts "Welcome to Towers of Hanoi!"
    sleep 1.5
    puts "Please type in your name!"\
    "\nNo spaces, numbers, or special characters!"
  end

  def player_name_prompt
    begin
      @player_name = gets.chomp.downcase.capitalize
      quit?(@player_name)
      raise StandardError if !!(/\s+|\W|\d/.match(@player_name))
    rescue
      puts "\nERROR: did not correctly enter the player's name."\
          " Please try again."
      retry
    end
    self.set_player_name(@player_name)
  end

  def difficulty_prompt
    puts "\nHello, #{@player_name}. Select a difficulty level!"\
         "\n[EASY || MEDIUM || HARD]"
    begin
      @app_difficulty = gets.chomp.downcase
      quit?(@app_difficulty.to_s)
      raise StandardError if !(/easy|medium|hard/i.match(@app_difficulty))
      @app_difficulty = @app_difficulty.to_sym
    rescue
      puts "\nERROR: did not correctly enter the difficulty."\
          " Please try again."
      retry
    end
    self.set_difficulty(@app_difficulty)
  end


  #Check for whether a valid choice of tower was made.
  def tower_choice_error(tower_choice, option = {})
    topmost_choice = self.towers[tower_choice][-1]
    topmost_source = self.towers[@source_tower][-1]
    raise StandardError if\
      !(/first|second|third/i.match(tower_choice))\
      ||(option == :source && self.towers[tower_choice].empty?)\
      ||((option == :destination && topmost_choice < topmost_source) \
      unless self.towers[tower_choice].empty?)
  end

  #Text output for prompts.
  def prompt_text (option)
    puts "Whose disc will you remove?" if option == :source
    puts "Where would you like to place the disc?" if option == :destination
    puts "[FIRST || SECOND || THIRD]"
  end

  #Store choice in instance variables
  def set_choice (choice,option)
    @source_tower = choice if option == :source
    @destination_tower = choice if option == :destination
  end

  #Checking for choice or render.
  def choice_prompt_check (option)
    while true
      prompt_text(option)
      tower = gets.chomp.downcase.to_sym
      !!(/render/i.match(tower.to_s)) ? self.render : break
    end
    tower
  end

  #Prompt for tower choice.
  def tower_choice_prompt (option)
    begin
      tower = choice_prompt_check(option)
      quit?(tower.to_s)
      set_choice(tower,option)
      self.tower_choice_error(tower,option)
    rescue
      puts "ERROR: did not correctly enter a tower choice."\
        " Please try again."
      retry
    end
    tower
  end

  #Picking a source tower.
  def source_tower_choice
    tower_choice_prompt(:source)
  end

  #Picking a destination tower.
  def destination_tower_choice
    tower_choice_prompt(:destination)
  end

  def method_missing(method_name, *args, &block)
    @messages << method_name
    @target.send(method_name, *args, &block)
  end
end
