class Anime::Search < BrowserAction
  get "/anime/search" do
    query = params.get(:q)
    html SearchPage, anime: AnimeQuery.new.title.ilike("%#{query.to_s}%"), query: query
  end
end
