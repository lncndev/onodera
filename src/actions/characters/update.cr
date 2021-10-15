class Characters::Update < BrowserAction
  put "/characters/:character_id" do
    character = CharacterQuery.find(character_id)
    SaveCharacter.update(character, params) do |operation, updated_character|
      if operation.saved?
        flash.success = "The record has been updated"
        redirect Show.with(updated_character.id)
      else
        flash.failure = "It looks like the form is not valid"
        html EditPage, operation: operation, character: updated_character
      end
    end
  end
end
