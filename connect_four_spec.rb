require_relative 'script'


describe Game do

    describe "#player_name" do
        subject(:name_input) {described_class.new} 

        it "displays the correct player number, 1 in this case" do
            message = "Please enter player 1's name."
            expect(name_input).to receive(:puts).with(message).once
            name_input.player_name(1, "\u{25CD}")
        end
    end

    describe '#play' do
        context 'Governing class to run the flow of the game' do 
            #subject(:play_game) { described_class.new}
            
        end
    end

    describe '#valid_selection?' do
        context 'make sure only user column input of single numbers 1-7 returns true' do 
            subject(:valid) { described_class.new}
            
            it "returns true when given 2" do
                expect(valid.valid_selection?(2)).to eq(true)
            end

            it "returns false when given 0" do
                expect(valid.valid_selection?(0)).to eq(false)
            end

            it "returns false when given 8" do
                expect(valid.valid_selection?(8)).to eq(false)
            end

            it "returns false when given punctuation (!), after being converted to integer" do
                punc = "!"
                expect(valid.valid_selection?(punc.to_i)).to eq(false)
            end
        end
    end


end

describe Board do

    describe "#valid_move?" do
        context "using column 2 as a selection example" do
            subject(:valid) {described_class.new} 
            let(:slots) {valid.instance_variable_get(:@slots)}

            it "returns true when column is empty" do
                expect(valid.valid_move?(2)).to eq(true)
            end

            it "returns true when column has only 2 filled spaces" do
                slots[0][1] = "fill"
                slots[1][1] = "fill"
                expect(valid.valid_move?(2)).to eq(true)
            end

            it "returns false when column has top space filled" do
                slots[5][1] = "fill"
                expect(valid.valid_move?(2)).to eq(false)
            end
        end
    end

    describe "#board_full?" do
        subject(:board) {described_class.new} 
        let(:slots) {board.instance_variable_get(:@slots)}

        it "returns false when column is empty" do
            expect(board.board_full?).to eq(false)
        end

        it "returns true when top row is filled (by virtue all lower ones already filled)" do
            slots[5][0] = "fill"
            slots[5][1] = "fill"
            slots[5][2] = "fill"
            slots[5][3] = "fill"
            slots[5][4] = "fill"
            slots[5][5] = "fill"
            slots[5][6] = "fill"
            expect(board.board_full?).to eq(true)
        end
    end

    describe "#row_win" do
        subject(:board) {described_class.new} 
        let(:slots) {board.instance_variable_get(:@slots)}
        symbol = "x"

        it "returns false when row is empty" do
            expect(board.row_win(symbol)).to eq(false)
        end

        it "returns false when first row has 4 symbols but not consecutive" do
            slots[0][0] = symbol
            slots[0][1] = symbol
            slots[0][3] = symbol
            slots[0][4] = symbol
            expect(board.row_win(symbol)).to eq(false)
        end


        it "returns true when second row is filled with 4 in a row" do
            slots[0][0] = symbol
            slots[0][1] = symbol
            slots[0][2] = symbol
            slots[0][3] = symbol
            expect(board.row_win(symbol)).to eq(true)
        end
    end

    describe "#column_win" do
        subject(:board) {described_class.new} 
        let(:slots) {board.instance_variable_get(:@slots)}
        symbol = "x"

        it "returns false when row is empty" do
            expect(board.column_win(symbol)).to eq(false)
        end

        it "returns false when first row has 4 symbols but not consecutive" do
            slots[0][0] = symbol
            slots[1][0] = symbol
            slots[4][0] = symbol
            slots[5][0] = symbol
            expect(board.column_win(symbol)).to eq(false)
        end


        it "returns true when second row is filled with 4 in a row" do
            slots[0][1] = symbol
            slots[1][1] = symbol
            slots[2][1] = symbol
            slots[3][1] = symbol
            expect(board.column_win(symbol)).to eq(true)
        end
    end


    

end