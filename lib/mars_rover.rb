# frozen_string_literal: true

class MarsRover
  def initialize(position, direction)
    @position = position
    @direction = direction
    @cardinals = %w[N E S W].freeze
  end

  attr_reader :position

  attr_reader :direction

  def execute(instructions)
    instructions.each do |instruction|
      move(instruction)
      rotate(instruction)
    end
  end

  private

  def move(instruction)
    if instruction == 'f'
      forwards
    elsif instruction == 'b'
      backwards
    end
  end

  def forwards
    @position[1] += 1 if @direction == 'N'
    @position[0] += 1 if @direction == 'E'
    @position[1] -= 1 if @direction == 'S'
    @position[0] -= 1 if @direction == 'W'
  end

  def backwards
    @position[1] -= 1 if @direction == 'N'
    @position[0] -= 1 if @direction == 'E'
    @position[1] += 1 if @direction == 'S'
    @position[0] += 1 if @direction == 'W'
  end

  def rotate(instruction)
    if instruction == 'r'
      rotate_right
    elsif instruction == 'l'
      rotate_left
    end
  end

  def rotate_right
    if current_cardinal_index < 3
      @direction = @cardinals[current_cardinal_index + 1]
    elsif current_cardinal_index == 3
      @direction = 'N'
    end
  end

  def current_cardinal_index
    @cardinals.index(@direction)
  end

  def rotate_left
    @direction = @cardinals[current_cardinal_index - 1]
  end
end
