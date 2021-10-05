class Anime::EditPage < MainLayout
  needs operation : SaveAnime
  needs anime : Anime
  quick_def page_title, "Edit Anime with id: #{anime.id}"

  def content
    link "Back to all anime", Anime::Index
    h1 "Edit \"#{anime.title}\""
    render_anime_form(operation)
  end

  def render_anime_form(op)
    form_for Anime::Update.with(anime.id), style: "max-width:70%", class: "form-group" do
      # Edit fields in src/components/anime/form_fields.cr
      mount Anime::FormFields, op; br
      submit "Update", data_disable_with: "Updating...", class: "btn btn-primary"
    end
  end
end
