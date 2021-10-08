class Anime::FormFields < BaseComponent
  needs operation : SaveAnime

  def render
    mount Shared::Field, operation.title, label_text: "Title", &.text_input(autofocus: "true")
    br
    mount Shared::Field, operation.description, label_text: "Description", &.textarea(rows: "5")
    br
    mount Shared::Field, operation.image_url, label_text: "Image URL"
    br
    mount Shared::Field, operation.mal_id, label_text: "MAL ID"
    br
    mount Shared::Field, operation.age_rating, label_text: "Age Rating"
    br
    mount Shared::Field, operation.release, label_text: "Release"
    br
    mount Shared::Field, operation.episode_count, label_text: "Episode Count", &.number_input
  end
end
