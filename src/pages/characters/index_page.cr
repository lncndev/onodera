class Characters::IndexPage < MainLayout
  needs characters : CharacterQuery
  quick_def page_title, "All Characters"

  def content
    h1 "All Characters"
    link "New Character", to: Characters::New
    render_characters
  end

  def render_characters
    ul do
      characters.each do |character|
        li do
          link character.name, Characters::Show.with(character)
        end
      end
    end
  end
end
