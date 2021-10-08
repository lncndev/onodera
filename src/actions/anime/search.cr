class Anime::Search < BrowserAction
  post "/anime/search" do
    query = params.from_form_data["q"]
    html SearchPage, anime: AnimeQuery.new.title.ilike("%#{query.to_s}%"), query: query
  end
end
