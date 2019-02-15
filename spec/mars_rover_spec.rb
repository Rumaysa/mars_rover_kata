# frozen_string_literal: true

require_relative '../lib/mars_rover.rb'

describe MarsRover do
  context 'returns position' do
    it 'should return the position of the rover' do
      rover = MarsRover.new([0, 0], 'N',[[-10,10],[-10,10]])
      expect(rover.position).to eq([0, 0])
    end

    it 'should return a different position of the rover' do
      rover = MarsRover.new([1, 1], 'N',[[-10,10],[-10,10]])
      expect(rover.position).to eq([1, 1])
    end
  end

  context 'returns direction' do
    it 'returns N when facing north' do
      rover = MarsRover.new([0, 0], 'N',[[-10,10],[-10,10]])
      expect(rover.direction).to eq('N')
    end

    it 'returns E when facing east' do
      rover = MarsRover.new([0, 0], 'E',[[-10,10],[-10,10]])
      expect(rover.direction).to eq('E')
    end
  end

  context 'whilst facing north' do
    let (:rover) { MarsRover.new([0, 0], 'N',[[-10,10],[-10,10]]) }
    context 'moving forwards and backwards' do
      it 'can move forwards' do
        rover.execute(['f'])
        expect(rover.position).to eq([0, 1])
      end

      it 'can move backwards' do
        rover.execute(['b'])
        expect(rover.position).to eq([0, -1])
      end
      it 'can move forwards twice' do
        rover.execute(%w[f f])
        expect(rover.position).to eq([0, 2])
      end

      it 'can move backwards twice' do
        rover.execute(%w[b b])
        expect(rover.position).to eq([0, -2])
      end
    end

    context 'rotating left and right' do
      it 'can rotate right' do
        rover.execute(['r'])
        expect(rover.direction).to eq('E')
      end

      it 'can rotate left' do
        rover.execute(['l'])
        expect(rover.direction).to eq('W')
      end

      it 'can rotate right twice' do
        rover.execute(%w[r r])
        expect(rover.direction).to eq('S')
      end

      it 'can rotate left twice' do
        rover.execute(%w[l l])
        expect(rover.direction).to eq('S')
      end

      it 'can rotate right 4 times' do
        rover.execute(%w[r r r r])
        expect(rover.direction).to eq('N')
      end

      it 'can rotate left 4 times' do
        rover.execute(%w[l l l l])
        expect(rover.direction).to eq('N')
      end
    end
  end

  context 'whilst facing east' do
    let (:rover) { MarsRover.new([0, 0], 'E',[[-10,10],[-10,10]]) }
    context 'moving forwards and backwards' do
      it 'can move forward' do
        rover.execute(['f'])
        expect(rover.position).to eq([1, 0])
      end

      it 'can move backwards' do
        rover.execute(['b'])
        expect(rover.position).to eq([-1, 0])
      end

      it 'can move forward twice' do
        rover.execute(%w[f f])
        expect(rover.position).to eq([2, 0])
      end

      it 'can move backward twice' do
        rover.execute(%w[b b])
        expect(rover.position).to eq([-2, 0])
      end
    end
    context 'rotating left and right' do
      it 'can rotate right' do
        rover.execute(['r'])
        expect(rover.direction).to eq('S')
      end
      it 'can rotate left' do
        rover.execute(['l'])
        expect(rover.direction).to eq('N')
      end
    end
  end

  context 'whilst facing south' do
    let (:rover) { MarsRover.new([0, 0], 'S',[[-10,10],[-10,10]]) }
    context 'moving forwards and backwards' do
      it 'moves forward' do
        rover.execute(['f'])
        expect(rover.position).to eq([0, -1])
      end

      it 'moves forwards twice' do
        rover.execute(%w[f f])
        expect(rover.position).to eq([0, -2])
      end

      it 'moves backward' do
        rover.execute(['b'])
        expect(rover.position).to eq([0, 1])
      end

      it 'moves backward twice' do
        rover.execute(%w[b b])
        expect(rover.position).to eq([0, 2])
      end
    end
    context 'it can rotate' do
      it 'can rotate left' do
        rover.execute(['l'])
        expect(rover.direction).to eq('E')
      end
    end
  end

  context 'whilst facing west' do
    let(:rover) { MarsRover.new([0, 0], 'W',[[-10,10],[-10,10]]) }
    context 'whilst moving forwards and backwards' do
      it 'can move forward' do
        rover.execute(['f'])
        expect(rover.position).to eq([-1, 0])
      end

      it 'can move forward twice' do
        rover.execute(%w[f f])
        expect(rover.position).to eq([-2, 0])
      end

      it 'moved backward' do
        rover.execute(['b'])
        expect(rover.position).to eq([1, 0])
      end

      it 'moved backward twice' do
        rover.execute(%w[b b])
        expect(rover.position).to eq([2, 0])
      end
    end
  end

  context 'multiple instructions' do
    let (:rover) { MarsRover.new([0,0],'N',[[-10,10],[-10,10]])}
    it 'can return its new position and direction' do 
      rover.execute(['l','f', 'f', 'r'])
      expect(rover.position).to eq([-2,0])
      expect(rover.direction).to eq('N')
    end

    it 'can return its new position and direction' do 
      rover.execute(['b', 'r', 'f', 'f', 'r', 'b', 'l', 'l', 'b', 'l', 'f'])
      expect(rover.position).to eq([1, -1])
      expect(rover.direction).to eq('W')
    end
  end

  context 'reaches the edge of the grid' do
    it 'loops back to the opposite side of the grid' do
      rover = MarsRover.new([0,10],'N',[[-10,10],[-10,10]])
      rover.execute(['f'])
      expect(rover.position).to eq([0,-10])
    end

    it 'loops back to the opposite side of the grid' do
      rover = MarsRover.new([10,0],'E',[[-10,10],[-10,10]])
      rover.execute(['f'])
      expect(rover.position).to eq([-10, 0])
    end

    it 'loops back to the opposite side of the grid' do
      rover = MarsRover.new([0,-10],'S',[[-10,10],[-10,10]])
      rover.execute(['f'])
      expect(rover.position).to eq([0, 10])
    end

    it 'loops back to the opposite side of the grid' do
      rover = MarsRover.new([-10,0],'W',[[-10,10],[-10,10]])
      rover.execute(['f'])
      expect(rover.position).to eq([10,0])
    end
  end

end
