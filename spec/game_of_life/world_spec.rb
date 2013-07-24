require 'spec_helper'

module GameOfLife
  describe World do
    subject { World.new }

    it { should respond_to :rows }
    it { should respond_to :columns }
    it { should respond_to :grid }
    
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

      # it 'should contain a Cell in each grid element' do
      #   subject.grid.each do |row|
      #     row.each { |element| element.should be_an_instance_of Cell }
      #   end
      # end
    end
  end
end