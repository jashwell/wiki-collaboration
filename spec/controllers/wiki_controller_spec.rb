require 'rails_helper'

RSpec.describe WikiController

  describe "GET #index" do
    it "populates an array of wikis" do
      wiki = Factory(:wiki)
      get :index
      expect(assigns(:wiki)).to eq([wiki])
    end

    it "renders the :index view" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    it "assigns the requested wiki to @wiki" do
      wiki = Factory(:wiki)
      get :show, id: wiki
      expect(assigns(:wiki)).to eq([wiki])
    end

    it "renders the :show template" do
      get :show, id: wiki
      expect(response).to render_template(:show)
    end
  end

  describe "GET #new" do
    it "assigns a new Wiki to @wiki" do
      @wiki = Wiki.new
    end

    it "renders the :new template" do
      get :new, id: wiki
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new wiki in the database" do
        expect {
          post :create, wiki: Factory.attributes_for(:wiki)
        }.to change(Wiki, count).by(1)
      end

      it "redirects to the show page" do
        post :create, wiki: Factory.attributes_for(:wiki)
        expect(response).to redirect_to(Wiki.last)
      end
    end

    context "with invalid attributes" do
      it "does not save the new wiki in the database" do
        expect{
          post :create, wiki: Factory.attributes_for(:invalid_contact)
        }.to_not change(Wiki, :count)
      end

      it "re-renders the :new template" do
        post :create, wiki: Factory.attributes_for(:invalid_contact)
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PUT update' do
    before :each do
      @wiki = Factory(:wiki, title: "RSpec Title", body: "RSpec Body Text")
    end

    context "valid attributes" do
      it "located the requested wiki" do
        put :update, id: @wiki, wiki: Factory.attributes_for(:wiki)
        expect(assigns(:wiki)).to eq([wiki])
      end

      it "changes wiki's attributes" do
        put :update, id: @wiki,
          wiki: Factory.attributes_for(:wiki, title: "RSpec Title", body: "RSpec Body Text" )
          @wiki.reload
          @wiki.title.should eq("RSpec Title")
          @wiki.body.should eq("RSpec Body Text")
      end

      it "redirect to updated wiki" do 
        put :update, id: @wiki, wiki: Factory.attributes_for(:wiki)
        expect(response).to redirect_to(@wiki)
      end
    end

    context "invalid attributes" do
      it "locates the requested wiki" do
        put :update, id: @wiki, wiki: Factory.attributes_for(:invalid_wiki)
        expect(assigns(:wiki)).to eq([wiki])
      end

      it "does not change wiki's attributes" do
        put :update, id: @wiki,
          wiki: Factory.attributes_for(:wiki, titel: "nil", body: "RSpec Body Text")
          @wiki.reload
          @wiki.title.should_not eq("RSpec Title")
          @wiki.body.should eq("RSpec Body Text")
      end


      it "re-renders the edit method" do
        put :update, id: @wiki, wiki: Factory.attributes_for(:invalid_wiki)
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE destroy' do
    before :each do
      @wiki = Factory(:wiki)
    end

    it "deletes the wiki" do
      expect {
        delete :destroy, id: @wiki
      }.to change(Wiki, :count).by(-1)
    end

    it "redirects to wiki#index" do
      delete :destroy, id: @wiki
      expect(response).to redirect_to(wiki_url)
    end
  end

