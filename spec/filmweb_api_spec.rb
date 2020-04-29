require 'filmweb_api'

RSpec.describe FilmwebApi do
  describe "#get" do
    let(:RestClient) { double }
    let(:response) { double }

    before do
      allow(RestClient).to receive(:get).and_return(response)
    end

    context "when user pass correct method and movie id" do
      let(:method) { "getFilmInfoFull" }
      let(:movie_id) { 107404 }

      it "should return response with film details" do
        allow(response).to receive(:body) {
          "ok\n[\"Piraci z Karaibów: Skrzynia umarlaka\",\"Pirates of the Caribbean: Dead Man\'s Chest\",7.7566957,406224,\"Fantasy,Przygodowy\",2006,150,0,\"https://www.filmweb.pl/film/Piraci+z+Karaib%C3%B3w%3A+Skrzynia+umarlaka-2006-107404/discussion\",1,1,\"/74/04/107404/7518098.2.jpg\",null,\"2006-06-24\",\"2006-07-21\",0,0,0,\"USA\",\"Jack Sparrow musi spłacić dług zaciągnięty wobec kapitana Latającego Holendra. Uniknie śmierci, gdy znajdzie i zniszczy serce Davy\'ego Jonesa ukryte w Skrzyni Umarlaka.\"] t:43200\n"
        }

        expect(FilmwebApi.new(method: method, movie_id: movie_id).get[:title]).to eq("Piraci z Karaibów: Skrzynia umarlaka")
        expect(FilmwebApi.new(method: method, movie_id: movie_id).get[:genres]).to eq("Fantasy,Przygodowy")
      end
    end

    context "when user pass one empty argument" do
      let(:method) { "" }
      let(:movie_id) { 107404 }

      it "should raise ArgumentError" do
        allow(response).to receive(:body) {
          "ok\n[\"Piraci z Karaibów: Skrzynia umarlaka\",\"Pirates of the Caribbean: Dead Man\'s Chest\",7.7566957,406224,\"Fantasy,Przygodowy\",2006,150,0,\"https://www.filmweb.pl/film/Piraci+z+Karaib%C3%B3w%3A+Skrzynia+umarlaka-2006-107404/discussion\",1,1,\"/74/04/107404/7518098.2.jpg\",null,\"2006-06-24\",\"2006-07-21\",0,0,0,\"USA\",\"Jack Sparrow musi spłacić dług zaciągnięty wobec kapitana Latającego Holendra. Uniknie śmierci, gdy znajdzie i zniszczy serce Davy\'ego Jonesa ukryte w Skrzyni Umarlaka.\"] t:43200\n"
        }

        expect{ FilmwebApi.new(method: method, movie_id: movie_id).get[:title] }.to raise_error(ArgumentError)
      end
    end

    context "when FilmWeb returns empty response" do
      let(:method) { "getFilmInfoFull" }
      let(:movie_id) { 107404 }

      it "should raise ArgumentError" do
        allow(response).to receive(:body) { "" }

        expect{ FilmwebApi.new(method: method, movie_id: movie_id).get[:title] }.to raise_error(StandardError)
      end
    end
  end
end
