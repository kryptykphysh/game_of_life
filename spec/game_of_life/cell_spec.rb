require 'spec_helper'

module GameOfLife
  describe Cell do
    subject { Cell.new }

    it { should be_an_instance_of Cell }
    it { should respond_to :state }

    describe '#new' do
      it 'should have a state of :dead' do
        subject.state.should == :dead
      end
    end
  end
end