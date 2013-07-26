require 'spec_helper'

module GameOfLife
  describe World do
    subject { World.new }

    it { should respond_to :rows }
    it { should respond_to :columns }
    it { should respond_to :grid }
    it { should respond_to :cells }
    
    describe '#new' do
      it { should be_an_instance_of(World) }

      context 'without rows or columns arguments' do
        it 'should have ten rows' do
          subject.rows.should == 10
        end

        it 'should have ten columns' do
          subject.columns.should == 10
        end
      end

      it 'should have a grid array' do
        subject.grid.should be_an_instance_of Array
      end

      it 'should have a grid that is a two dimensional array' do
        subject.grid.each { |row| row.should be_an_instance_of Array }
      end

      it 'should have a Cell in each element' do
        subject.grid.flatten.all? do |element|
          element.should be_an_instance_of Cell
        end
      end

      it 'should have all :dead elements' do
        subject.grid.flatten.all? { |element| element.state == :dead }
      end
    end

    describe ':cells' do
      subject { World.new.cells }

      it { should be_an_instance_of Array }

      it 'should contain only Cell instances' do
        subject.all? { |cell| cell.instance_of?(Cell) }.should be_true
      end

      it 'should have the same size as the grid' do
        subject.size.should == 100
      end

      it 'should have cells with neighbouring cell positions' do
        subject.each do |cell|
          cell.neighbours.should_not be_empty
        end
      end
    end
  end
end