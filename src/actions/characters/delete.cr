class Characters::Delete < BrowserAction
  delete "/characters/:character_id" do
    character = CharacterQuery.find(character_id)
    DeleteCharacter.delete(character) do |_operation, _deleted|
      flash.success = "Deleted the character"
      redirect Index
    end
  end
end
