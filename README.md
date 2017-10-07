# Mars Rover Challenge

## Usage
- Install [Ruby](https://www.ruby-lang.org/en/downloads/) if not already on
  machine

### Solution
- From project root run `ruby app/mission_controll.rb`

This will kick off Mission Control for controlling the Mars Rover.
When prompted with _Enter command file name:_ type in `test1.xt` or the path to
any other file containing commands. The expected result for command files
_test1.txt_ and _test2.txt_ can be found on the last line of each file.

The output will show you the current position and bearing of the Rover on the
printed line with _Final position:_

### Tests
- Install RSpec by running `gem install rspec`
- In the project root folder, run `rspec` to execute tests

## Description
The program has been split up into 2 main parts, each encapsulated within its
own class. Each part has been tested to validate that their interfaces produce
expected results when receiving specific inputs.
The different parts, distributed by their responsibility of duties,
are:

### 1. Mission Control
The `MissionControl` class in `app/mission_control.rb` is responsible for receiving
user input which specifies the file containing the Rover's configuration and
commands instruction.
Mission Control is also responsible for displaying any output to the
user(console).

**Design**:
- The logic of extracting the config & command properties from the input file has
  been extracted into it's own function. If the format of how these files are
  structured where to change, the public user interface `#start_rover_mission`
  would not be tampered. Only `#props_from_file` would need to be updated to
  correct read the data from the file and return the properties in the expected
  agreed format.

**Testing**: _spec/mission_control_spec.rb_
- The correctness of MissionControl's functionality has been insured by testing
  that `#start_rover_mission` with a specified input, outputs the expected and correct output to console

### 2. Rover
The `Rover` class in `app/rover.rb` is responsible for configuring the
properties of the Rover as given by Mission Control, and allow execution of a
list of commands.

**Design**:
- The Rover has be setup with a public interface that will allow the user to view
  the zone, current_position, and a function to execute a list of commands.
  Rover is not responsible for the way in which input is received, and output
  displayed to the user.
- There are more granular functionalities related to the execution of individual
  events, which should only be accessed internally for use by the Rover itself.
  This also includes the DIRECTION_MAPPING to determine bearing. The user of the
  Rover should not be concerned about specific and implementation details.

**Testing**: _spec/rover_spec.rb_
- The correctness of the Rover has been ensured by testing that when initialized
  with specific values, the properties are set and return the expected result to
  the user when they access one of the public methods.
- The main functionality of the Rover is to execute the given commands, and this
  has been tested by ensuring that a predefined input always return the same
  expected result containing the final location. Note that an empty command list
  should not move the Rover at all.
- There are also a few specs which have been commented out:
  - These would serve to test that the Rover behaves as expected when an
    edge case is encountered, such as invalid input. This should be implemented
    if the expected behaviour is included in the specifications. This would then
    require updating the `rover.rb` to ensure that it behaves as specified.
