class AutogenYAMLDataset::Show < ApiAction
  include Api::Auth::SkipRequireAuthToken

  get "/data.yaml" do
    plain_text File.read("data.yaml").to_s
  end
end
