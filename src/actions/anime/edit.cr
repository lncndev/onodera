class Anime::Edit < BrowserAction
  get "/anime/:anime_id/edit" do
    anime = AnimeQuery.find(anime_id)
    html EditPage,
      operation: SaveAnime.new(anime),
      anime: anime
  end
end
