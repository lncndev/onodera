require "markd"

class Docs::Show < BrowserAction
  get "/docs" do
    html ShowPage
  end
end
