class Anime::Show < BrowserAction
  get "/anime/:anime_id" do
    html ShowPage, anime: AnimeQuery.find(anime_id)
  end
end
