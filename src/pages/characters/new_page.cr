class Characters::NewPage < MainLayout
  needs operation : SaveCharacter
  quick_def page_title, "New Character"

  def content
    h1 "New Character"
    render_character_form(operation)
  end

  def render_character_form(op)
    form_for Characters::Create do
      # Edit fields in src/components/characters/form_fields.cr
      mount Characters::FormFields, op; br
      submit "Save", data_disable_with: "Saving...", class: "btn btn-primary"
    end
  end
end
