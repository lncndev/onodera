class Characters::EditPage < MainLayout
  needs operation : SaveCharacter
  needs character : Character
  quick_def page_title, "Edit Character with id: #{character.id}"

  def content
    link "Back to all Characters", Characters::Index
    h1 "Edit Character with id: #{character.id}"
    render_character_form(operation)
  end

  def render_character_form(op)
    form_for Characters::Update.with(character.id) do
      # Edit fields in src/components/characters/form_fields.cr
      mount Characters::FormFields, op; br
      submit "Update", data_disable_with: "Updating...", class: "btn btn-primary"
    end
  end
end
