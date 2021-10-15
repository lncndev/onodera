class Characters::Edit < BrowserAction
  get "/characters/:character_id/edit" do
    character = CharacterQuery.find(character_id)
    html EditPage,
      operation: SaveCharacter.new(character),
      character: character
  end
end
