require_relative 'script'


describe Game do
    #no test needed for welcome_message

    describe "#player_name" do
        subject(:name_input) {described_class.new} 

        it "displays the correct player number, 1 in this case" do
            message = "Please enter player 1's name."
            expect(name_input).to receive(:puts).with(message).once
            name_input.player_name(1)
        end

        before do
            player_input = "name"
            allow(name_input).to receive(:gets).and_return(player_input)
        end
    end






end