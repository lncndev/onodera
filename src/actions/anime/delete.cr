class Anime::Delete < BrowserAction
  delete "/anime/:anime_id" do
    anime = AnimeQuery.find(anime_id)
    DeleteAnime.delete(anime) do |_operation, _deleted|
      flash.success = "Deleted the anime"
      redirect Index
    end
  end
end
