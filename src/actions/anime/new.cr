class Anime::New < BrowserAction
  get "/anime/new" do
    html NewPage, operation: SaveAnime.new
  end
end
