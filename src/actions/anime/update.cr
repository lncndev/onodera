class Anime::Update < BrowserAction
  put "/anime/:anime_id" do
    anime = AnimeQuery.find(anime_id)
    SaveAnime.update(anime, params) do |operation, updated_anime|
      if operation.saved?
        flash.success = "The record has been updated"
        redirect Show.with(updated_anime.id)
      else
        flash.failure = "It looks like the form is not valid"
        html EditPage, operation: operation, anime: updated_anime
      end
    end
  end
end
