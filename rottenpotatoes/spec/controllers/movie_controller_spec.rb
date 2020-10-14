require 'rails_helper'


describe MoviesController do
    describe "#director" do
        context "When movie has a director" do
            it "should retrieve movies with the same director as a movie given id" do
                @movie=double(:title => 'Interstellar', :director => 'Christopher Nolan', :id => 1)
                @movies=[double(:title => 'Interstellar', :director => 'Christopher Nolan'),double(:title => 'Tenet', :director => 'Christopher Nolan')]
                expect(Movie).to receive(:find).and_return(@movie)
                expect(Movie).to receive(:same_director).and_return(@movies)
                get :director, id:  @movie.id
                expect(response).to render_template(:director)
            end
        end
        context "When movie does not have a director" do
            it "should redirect to the home page" do
                @movie=double(:title => 'directorless_movie', :rating => 'G', :director => '', :description => '', :release_date => "1999-1-1", :id => 2)
                expect(Movie).to receive(:find).and_return(@movie)
                get :director, :id => @movie.id
                expect(response).to redirect_to(movies_path)
            end
        end
    end
    describe "#create" do
        it "should create a movie with given parameters" do
            @movie = double().as_null_object
            expect(Movie).to receive(:create!).and_return(@movie)
            post :create, :movie => {:title => 'new movie', :rating => 'G', :director => '', :description => '', :release_date => "1999-1-1"}
            expect(response).to redirect_to(movies_path)
        end
    end
    describe "#show" do
        it "should display details from a movie given id" do
            @movie=double(:title => "Interstellar", :rating => "R", :director => "Christopher Nolan", :description => 'good movie', :release_date => "2014-10-26", :id => 1)
            expect(Movie).to receive(:find).and_return(@movie)
            get :show, :id => @movie.id
            expect(response).to render_template(:show)
        end
    end
    describe "#destroy" do
        it "should delete selected movie given id" do
            @movie=double(:title => "Interstellar", :rating => "R", :director => "Christopher Nolan", :description => 'good movie', :release_date => "2014-10-26", :id => 1)
            expect(Movie).to receive(:find).and_return(@movie)
            expect(@movie).to receive(:destroy)
            delete :destroy, :id => @movie.id
            expect(response).to redirect_to(movies_path)
        end
    end
    describe "#edit" do
        it "should get edit a movie given id" do
            @movie=double(:title => "Interstellar", :rating => "R", :director => "Christopher Nolan", :description => 'good movie', :release_date => "2014-10-26", :id => 1)
            expect(Movie).to receive(:find).and_return(@movie)
            get :edit, :id => @movie.id
            expect(response).to render_template(:edit)
        end
    end
    describe "#update" do
        it "should update details of a movie given id" do
            @movie=double(:title => "Interstellar", :rating => "R", :director => "Christopher Nolan", :description => 'good movie', :release_date => "2014-10-26", :id => 1).as_null_object
            @new_params={:title => "Tenet", :rating => "R", :director => 'Christopher Nolan', :description => 'good movie', :release_date => "2020-09-03"}
            expect(Movie).to receive(:find).and_return(@movie)
            put :update, :id => @movie.id, :movie => @new_params
            expect(response).to redirect_to(movie_path(@movie))
        end
    end
    describe '#index' do
        it 'should show the index template' do
            get :index
            expect(response).to render_template(:index)
        end  
        it 'should filter with all ratings selected' do
            Movie.should_receive(:all_ratings).and_return( %w(G PG PG-13 NC-17 R));
            get :index
        end
    end  
    describe "#new" do
        it "should show the new template" do
            get :new 
            expect(response).to render_template(:new)
        end
    end
end