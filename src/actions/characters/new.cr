class Characters::New < BrowserAction
  get "/characters/new" do
    html NewPage, operation: SaveCharacter.new
  end
end
