# frozen_string_literal: true

# Rover: used to execute set of commands based preconfigured placement
class Rover
  DIRECTION_MAPPING = {
    'W' => 0, 'N' => 90, 'E' => 180, 'S' => 270
  }.freeze
  private_constant :DIRECTION_MAPPING

  attr_reader :zone

  # Configures a new Rover
  #
  # @example
  #
  # zone = [8, 8] # 8X8 zone, grid of 64 blocks
  # starting_postition = [1, 2, 'E']
  #
  # rover = Rover.new(zone, starting_position)
  #
  # rover.zone                                            #=> [8, 8]
  # rover.current_position                                #=> [1, 2, 'E']
  # rover.execute_commands(%w[M M L M R M M R R M M L])   #=> [3, 3, 'S']
  #
  # @param [Array] zone: The size of the cartesian zone as [x, y]
  # @param [Array] starting_position: The coordinates and bearing of the Rover's
  # initial position as [starting_x, starting_y, bearing].
  def initialize(zone, starting_position)
    @zone = zone
    @current_x, @current_y, @direction = starting_position
  end

  def current_position
    [@current_x, @current_y, @direction]
  end

  def execute_commands(commands)
    execute(commands.shift) until commands.empty?
    current_position
  end

  private

  # Execute a single command
  def execute(command)
    case command
    when 'M'
      move_forward
    when 'R'
      # rotate 90 right
      change_direction(DIRECTION_MAPPING[@direction] + 90)
    when 'L'
      # rotate 90 left
      change_direction(DIRECTION_MAPPING[@direction] - 90)
    end
  end

  def move_forward
    case @direction
    when 'N' then @current_y += 1
    when 'E' then @current_x += 1
    when 'S' then @current_y -= 1
    when 'W' then @current_x -= 1
    end
  end

  def change_direction(degrees)
    # If the degrees is 360, reset to 0
    degrees = degrees == 360 ? 0 : degrees
    # If the degrees is 360, reset to 270
    degrees = degrees == -90 ? 270 : degrees

    @direction = DIRECTION_MAPPING.invert[degrees]
  end
end
