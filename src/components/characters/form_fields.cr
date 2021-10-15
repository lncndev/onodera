class Characters::FormFields < BaseComponent
  needs operation : SaveCharacter

  def render
    mount Shared::Field, operation.name, &.text_input(autofocus: "true")
    mount Shared::Field, operation.bio
    mount Shared::Field, operation.image_url
  end
end
