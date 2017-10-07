# frozen_string_literal: true

RSpec.describe 'Rover' do
  let(:zone) { [8, 8] }
  let(:start) { [1, 2, 'E'] }

  context '#new' do
    it 'initializes new rover with correct properties' do
      rover = Rover.new(zone, start)
      expect(rover.zone).to eq(zone)
      expect(rover.current_position).to eq(start)
    end

    # it 'raises error when zone is invalid'
    # it 'raises error when start position is invalid'
  end

  context '#execute_commands' do
    let(:rover) { Rover.new(zone, start) }

    it 'returns resulting position' do
      commands = %w[M M L M R M M R R M M L]
      expect(rover.execute_commands(commands)).to eq([3, 3, 'S'])
    end

    it 'does not move with empty command list' do
      expect { rover.execute_commands([]) }
        .not_to change { rover.current_position }
    end

    # it 'raises error when list contains invalid command'
    # it 'raises error when commands move Rover out of zone bounds'
  end
end
