# frozen_string_literal: true

RSpec.describe 'MissionControl' do
  context '#start_rover_mission' do
    it 'outputs rovers result of input' do
      expect do
        MissionControl.start_rover_mission('test1.txt')
      end.to output("Final position: 3 3 S\n").to_stdout
    end
  end
end
