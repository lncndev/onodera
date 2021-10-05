class Anime::Search < BrowserAction
  get "/anime/search" do
    query = params.get(:q)
    puts query
    html SearchPage, anime: AnimeQuery.new.title.ilike("%#{query.to_s}%")
  end
end
