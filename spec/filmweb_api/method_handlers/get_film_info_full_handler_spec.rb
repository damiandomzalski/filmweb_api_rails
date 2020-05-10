require 'filmweb_api'

RSpec.describe GetFilmInfoFullHandler do
  describe "#call" do
    let(:filmweb_response) { double }
    let(:subject) { GetFilmInfoFullHandler.new(attributes).call }

    context "when user pass incorrect attributes" do
      let(:attributes) { { unsupported_attribute: "yeah, I'm unsupported!" } }

      before { allow_any_instance_of(GetFilmInfoFullHandler).to receive(:all_required_attributes?).and_return(false) }

      it "should raise ArgumentError with error message" do
        expect{ subject }.to raise_error(ArgumentError, "You need to pass all required attributes for that method")
      end
    end

    context "when user pass correct attributes" do
      let(:attributes) { { movie_id: 12345 } }
      let(:response) { [
        "Piraci z Karaibów: Skrzynia umarlaka",
        "Pirates of the Caribbean: Dead Man's Chest",
        "7.7563286",
        "406662",
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
      let(:hashed_response) {
        {
          avgRate: "7.7563286",
          commentsCount: "0",
          countriesString: "USA",
          desciption: "Jack Sparrow musi spłacić dług zaciągnięty wobec kapitana Latającego Holendra. Uniknie śmierci, gdy znajdzie i zniszczy serce Davy'ego Jonesa ukryte w Skrzyni Umarlaka.",
          duration: "150",
          episodesCount: "0",
          filmType: "0",
          forumUrl: "https://www.filmweb.pl/film/Piraci+z+Karaib%C3%B3w%3A+Skrzynia+umarlaka-2006-107404/discussion",
          genres: "Fantasy,Przygodowy",
          hasDescription: "1",
          hasReview: "1",
          imagePath: "/74/04/107404/7518098.2.jpg",
          originalTitle: "Pirates of the Caribbean: Dead Man's Chest",
          premiereCountry: "2006-07-21",
          premiereWorld: "2006-06-24",
          seasonsCount: "0",
          title: "Piraci z Karaibów: Skrzynia umarlaka",
          video: nil,
          votesCount: "406662",
          year: "2006"
        }
      }

      before { allow_any_instance_of(GetFilmInfoFullHandler).to receive(:filmweb_response).and_return(response) }

      it "should return hashed filmweb response" do
        expect(subject).to eq(hashed_response)
      end
    end
  end
end
