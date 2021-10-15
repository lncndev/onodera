class Characters::Create < BrowserAction
  post "/characters" do
    SaveCharacter.create(params) do |operation, character|
      if character
        flash.success = "The record has been saved"
        redirect Show.with(character.id)
      else
        flash.failure = "It looks like the form is not valid"
        html NewPage, operation: operation
      end
    end
  end
end
