class Anime::FormFields < BaseComponent
  needs operation : SaveAnime

  def render
    mount Shared::Field, operation.title, &.text_input(autofocus: "true", replace_class: "form-input")
    br
    mount Shared::Field, operation.description, &.textarea(rows: "5", replace_class: "form-input")
    br
    mount Shared::Field, operation.image_url
  end
end
