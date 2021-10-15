class Characters::ShowPage < MainLayout
  needs character : Character
  quick_def page_title, "Character with id: #{character.id}"

  def content
    link "Back to all Characters", Characters::Index
    h1 "Character with id: #{character.id}"
    render_actions
    render_character_fields
  end

  def render_actions
    section do
      link "Edit", Characters::Edit.with(character.id)
      text " | "
      link "Delete",
        Characters::Delete.with(character.id),
        data_confirm: "Are you sure?"
    end
  end

  def render_character_fields
    ul do
      li do
        text "name: "
        strong character.name.to_s
      end
      li do
        text "bio: "
        strong character.bio.to_s
      end
      li do
        text "image_url: "
        strong character.image_url.to_s
      end
    end
  end
end
