require 'spec_helper'

module GameOfLife
  describe Cell do
    subject { Cell.new }
    
    it { should be_an_instance_of Cell }
    it { should respond_to :state }
    it { should respond_to :position }
    it { should respond_to :neighbours }
    it { should respond_to :live! }
    it { should respond_to :alive? }
    it { should respond_to :die! }
    it { should respond_to :dead? }

    describe '#new' do
      it 'should be dead' do
        subject.state.should == :dead
      end

      it 'should have a :position' do
        subject.position.should_not be_empty
      end
    end

    describe ':position' do
      subject { Cell.new.position }

      it { should be_an_instance_of Hash }

      it 'should have an :x coordinate' do
        subject.keys.should include(:x)
      end

      it 'should have a :y coordinate' do
        subject.keys.should include(:y)
      end
    end

    describe "#alive?" do
      context 'for a :dead Cell' do
        it 'should be false' do
          @cell = GameOfLife::Cell.new
          @cell.alive?.should be_false
        end
      end

      context 'for an :alive Cell' do
        before(:each) do
          @cell = Cell.new
          @cell.live!
        end
        it 'should be true' do
          @cell.alive?.should be_true
        end
      end
    end


    describe "#live!" do
      context 'for a :dead cell' do
        it 'should change :state from :dead to :alive' do
          expect { subject.live! }.
            to change { subject.state }.from(:dead).to(:alive)
        end
      end

      context 'for an :alive Cell' do
        it 'should remain :alive' do
          expect { subject.live! }.
            to_not change { subject.alive? }.from(true)
        end
      end
    end

    describe "#dead?" do
      context 'for a :dead Cell' do
        it 'should be true' do
          @cell = GameOfLife::Cell.new
          @cell.dead?.should be_true
        end
      end

      context 'for an :alive Cell' do
        before(:each) do
          @cell = Cell.new
          @cell.live!
        end
        it 'should be false' do
          @cell.dead?.should be_false
        end
      end
    end

    describe "#die!" do
      context 'for an :alive cell' do
        before(:each) { subject.state = :alive }
        it 'should change :state from :alive to :dead' do
          expect { subject.die! }.
            to change { subject.state }.from(:alive).to(:dead)
        end
      end

      context 'for a :dead Cell' do
        before(:each) { subject.state = :alive }
        it 'should remain :dead' do
          expect { subject.die! }.
            to_not change { subject.alive? }.from(false)
        end
      end
    end
  end
end