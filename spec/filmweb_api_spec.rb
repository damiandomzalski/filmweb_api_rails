require 'filmweb_api'

RSpec.describe FilmwebApi do
  describe "#get" do
    let(:method_handler) { double }
    let(:subject) { FilmwebApi.new(method: method, movie_id: movie_id).get }

    context "when user pass not supported method" do
      let(:method) { "getNothing" }
      let(:movie_id) { 107404 }

      before { allow_any_instance_of(FilmwebApi).to receive(:method_supported?).and_return(false) }

      it "should raise ArgumentError with error message" do
        expect{ subject }.to raise_error(ArgumentError, "Passed method not supported")
      end
    end

    context "when user pass incorrect attributes" do
      let(:method) { "getFilmInfoFull" }
      let(:movie_id) { "" }

      before { allow_any_instance_of(FilmwebApi).to receive(:correct_attributes_for_method?).and_return(false) }

      it "should raise ArgumentError with error message" do
        expect{ subject }.to raise_error(ArgumentError, "You need to pass all required attributes for that method")
      end
    end

    context "when user pass supported method and correct attributes" do
      let(:method) { "getFilmInfoFull" }
      let(:movie_id) { 107404 }

      it "should return response with film details" do
        allow(method_handler).to receive(:call).and_return(
          "ok\n[\"Piraci z Karaibów: Skrzynia umarlaka\",\"Pirates of the Caribbean: Dead Man\'s Chest\",7.7566957,406224,\"Fantasy,Przygodowy\",2006,150,0,\"https://www.filmweb.pl/film/Piraci+z+Karaib%C3%B3w%3A+Skrzynia+umarlaka-2006-107404/discussion\",1,1,\"/74/04/107404/7518098.2.jpg\",null,\"2006-06-24\",\"2006-07-21\",0,0,0,\"USA\",\"Jack Sparrow musi spłacić dług zaciągnięty wobec kapitana Latającego Holendra. Uniknie śmierci, gdy znajdzie i zniszczy serce Davy\'ego Jonesa ukryte w Skrzyni Umarlaka.\"] t:43200\n"
        )

        expect(subject[:title]).to eq("Piraci z Karaibów: Skrzynia umarlaka")
        expect(subject[:genres]).to eq("Fantasy,Przygodowy")
      end
    end
  end
end
