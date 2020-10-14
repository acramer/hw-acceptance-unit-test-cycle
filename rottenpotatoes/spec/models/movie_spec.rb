require 'rails_helper'

describe Movie do
    describe "#same_director" do
        it "should return movies by the same director" do
            movie1 = Movie.create! :director => "Christopher Nolan"
            movie2 = Movie.create! :director => "Christopher Nolan"
            expect(Movie.same_director(movie1.director)).to include(movie2)
        end
        it "should not return movies by two different directors" do
            movie1 = Movie.create! :director => "Christopher Nolan"
            movie2 = Movie.create! :director => "Ari Aster"
            expect(Movie.same_director(movie1.director)).to_not include(movie2)
        end
    end
    describe '#all_ratings' do
        it 'returns all movie ratings' do
            expect(Movie.all_ratings).to match(%w(G PG PG-13 NC-17 R))
        end
    end
end 