# frozen_string_literal: true

require_relative 'rover'

# Mission Control: for configuring rover, sending commands and printing results
class MissionControl
  # Begin the mission
  #
  # @param [String] file_name: path to the command file relative from where
  # program was executed
  def self.start_rover_mission(file_name)
    file = File.open(file_name)
    zone, start_position, commands = props_from_file(file)
    file.close

    rover = Rover.new(zone, start_position)
    result = rover.execute_commands(commands).join(' ')

    puts "Final position: #{result}"
  end

  # Extract all required properties from the file
  #
  # @param [File] file: The open file to extract properties from
  #
  # @return [Array]: An array of properties as [zone, start_position, commands]
  def self.props_from_file(file)
    lines = file.each_line

    zone = lines.next.strip.split.map(&:to_i)

    start_position = lines.next.strip.split
    # change first 2 items into integers because they are coordinates
    start_position[0..1] = start_position[0..1].map(&:to_i)

    commands = lines.next.strip.chars

    [zone, start_position, commands]
  end
  private_class_method :props_from_file
end

# if this file is actually being executed directly, and not required.
if $PROGRAM_NAME == __FILE__
  puts 'Running Mission Control for Mars Rover'
  print 'Enter command file name: '
  file_name = gets.strip

  puts '#' * 20
  MissionControl.start_rover_mission(file_name)
end
