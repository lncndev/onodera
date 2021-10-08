class Anime::Create < BrowserAction
  post "/anime" do
    SaveAnime.create(params) do |operation, anime|
      if anime
        flash.success = "The record has been saved"
        redirect Show.with(anime.id)
      else
        flash.failure = "It looks like the form is not valid"
        html NewPage, operation: operation
      end
    end
  end
end
