class Characters::Index < BrowserAction
  get "/characters" do
    html IndexPage, characters: CharacterQuery.new
  end
end
