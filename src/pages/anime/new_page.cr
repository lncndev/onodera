class Anime::NewPage < MainLayout
  needs operation : SaveAnime
  quick_def page_title, "Add Anime"

  def content
    link "Back to all anime", Anime::Index
    h1 "Add Anime"
    render_anime_form(operation)
  end

  def render_anime_form(op)
    form_for Anime::Create do
      # Edit fields in src/components/anime/form_fields.cr
      mount Anime::FormFields, op; br
      submit "Save", data_disable_with: "Saving...", class: "btn btn-primary"
    end
  end
end
