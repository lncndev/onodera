class Characters::Show < BrowserAction
  get "/characters/:character_id" do
    html ShowPage, character: CharacterQuery.find(character_id)
  end
end
