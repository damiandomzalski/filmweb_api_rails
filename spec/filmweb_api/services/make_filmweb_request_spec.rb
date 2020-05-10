require 'filmweb_api'

RSpec.describe MakeFilmwebRequest do
  describe "#call" do
    context "when got uncleaned filmweb api response" do
      let(:filmweb_response) {
        "ok\n[\"Piraci z Karaibów: Skrzynia umarlaka\",\"Pirates of the Caribbean: Dead Man\'s Chest\",7.7566957,406224,\"Fantasy,Przygodowy\",2006,150,0,\"https://www.filmweb.pl/film/Piraci+z+Karaib%C3%B3w%3A+Skrzynia+umarlaka-2006-107404/discussion\",1,1,\"/74/04/107404/7518098.2.jpg\",null,\"2006-06-24\",\"2006-07-21\",0,0,0,\"USA\",\"Jack Sparrow musi spłacić dług zaciągnięty wobec kapitana Latającego Holendra. Uniknie śmierci, gdy znajdzie i zniszczy serce Davy\'ego Jonesa ukryte w Skrzyni Umarlaka.\"] t:43200\n"
      }
      let(:cleaned_response) { [
        "Piraci z Karaibów: Skrzynia umarlaka",
        "Pirates of the Caribbean: Dead Man's Chest",
        "7.7566957",
        "406224",
        "Fantasy,Przygodowy",
        "2006",
        "150",
        "0",
        "https://www.filmweb.pl/film/Piraci+z+Karaib%C3%B3w%3A+Skrzynia+umarlaka-2006-107404/discussion",
        "1",
        "1",
        "/74/04/107404/7518098.2.jpg",
        nil,
        "2006-06-24",
        "2006-07-21",
        "0",
        "0",
        "0",
        "USA",
        "Jack Sparrow musi spłacić dług zaciągnięty wobec kapitana Latającego Holendra. Uniknie śmierci, gdy znajdzie i zniszczy serce Davy'ego Jonesa ukryte w Skrzyni Umarlaka."
        ]
      }
      let(:subject) { MakeFilmwebRequest.new(method: "someMethod", movie_id: 12345).call }

      before { allow_any_instance_of(MakeFilmwebRequest).to receive(:api_response_body).and_return(filmweb_response) }

      it "should cleanup response to array of vales" do
        expect(subject).to eq(cleaned_response)
      end
    end
  end
end
