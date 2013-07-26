require 'spec_helper'

module GameOfLife
  describe Game do
    subject { Game.new }

    it { should be_an_instance_of GameOfLife::Game }
    it { should respond_to :world }
    it { should respond_to :spawn_life }
    it { should respond_to :cells }
    it { should respond_to :evolve! }

    describe ':world' do
      subject { Game.new.world }

      it { should be_an_instance_of GameOfLife::World }
    end

    describe ':cells' do
      subject { Game.new.cells }

      it { should be_an_instance_of Array }
      it 'should contain Cells' do
        subject.all? { |cell| cell.instance_of? GameOfLife::Cell }.
          should be_true
      end
    end

    describe '#spawn_life' do
      subject { Game.new }
      
      it 'should randomly change Cells to :state :alive' do
        expect { subject.spawn_life }.
          to change{ subject.cells.count { |cell| cell.state == :alive } }.
          from(0)
      end
    end

    describe "#evolve!" do

      describe 'Rule 1: Any live cell with fewer than two live neighbours dies' do
        before(:each) do
          @game = Game.new
          @target_cell = @game.cells.find { |cell| cell.position == { x: 1, y: 1} }
          @target_cell.live!
        end

        it 'should kill a living Cell with no live neighbours' do
          expect{ @game.evolve! }.to change{ @target_cell.alive? }.from(true).to(false)
        end

        it 'should kill a living Cell with one live neighbour' do
          @game.cells.find { |c| c.position == @target_cell.neighbours.first }.live!
          expect{ @game.evolve! }.to change{ @target_cell.alive? }.from(true).to(false)
        end
      end

      describe 'Rule 2: Any live cell with two or three live neighbours lives' do
        before(:each) do
          @game = Game.new
          @target_cell = @game.cells.find { |cell| cell.position == { x: 1, y: 1} }
        end
        context 'with two live neighbours' do
          before(:each) do
            @target_cell.live!
            neighbours_to_revive = @target_cell.neighbours.sample(2)
            @game.cells.select { |c| neighbours_to_revive.include?(c.position) }.
              each { |e| e.live! }
          end

          it 'should allow a living Cell to survive' do
            expect{ @game.evolve! }.to_not change{ @target_cell.alive? }.from(true)
          end
        end

        context 'with three live neighbours' do
          before(:each) do
            @target_cell.live!
            neighbours_to_revive = @target_cell.neighbours.sample(2)
            @game.cells.select { |c| neighbours_to_revive.include?(c.position) }.
              each { |e| e.live! }
          end

          it 'should allow a living Cell to survive' do
            expect{ @game.evolve! }.to_not change{ @target_cell.alive? }.from(true)
          end
        end
      end

      describe 'Rule 3: Any live cell with more than three live neighbours dies' do
        before(:each) do
          @game = Game.new
          @target_cell = @game.cells.find { |cell| cell.position == { x: 1, y: 1} }
        end

        context 'with four live neighbours' do
          before(:each) do
            @target_cell.live!
            neighbours_to_revive = @target_cell.neighbours.sample(4)
            @game.cells.select { |c| neighbours_to_revive.include?(c.position) }.
              each { |e| e.live! }
          end

          it 'should cause an :alive Cell to #die!' do
            expect{ @game.evolve! }.to change{ @target_cell.alive? }.from(true).to(false)
          end
        end

        context 'with eight live neighbours' do
          before(:each) do
            @target_cell.live!
            neighbours_to_revive = @target_cell.neighbours.sample(8)
            @game.cells.select { |c| neighbours_to_revive.include?(c.position) }.
              each { |e| e.live! }
          end

          it 'should cause an :alive Cell to #die!' do
            expect{ @game.evolve! }.to change{ @target_cell.alive? }.from(true).to(false)
          end
        end
      end

      describe "Rule 4: Any dead cell with exactly three live neighbours becomes a live cell" do
        before(:each) do
          @game = Game.new
          @target_cell = @game.cells.find { |cell| cell.position == { x: 1, y: 1} }
        end
        
        context 'with three live neighbours' do
          before(:each) do
            @target_cell.die!
            neighbours_to_revive = @target_cell.neighbours.sample(3)
            @game.cells.select { |c| neighbours_to_revive.include?(c.position) }.
              each { |e| e.live! }
          end

          it 'should cause a :dead Cell to #live!' do
            expect{ @game.evolve! }.to change{ @target_cell.alive? }.
              from(false).to(true)
          end
        end       
      end
    end
  end
end