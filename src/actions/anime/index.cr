class Anime::Index < BrowserAction
  # include Lucky::Paginator::BackendHelpers

  get "/anime" do
    # pages, anime = paginate(AnimeQuery.new, per_page: 50)
    # html IndexPage, anime: anime, pages: pages
    html IndexPage, anime: AnimeQuery.new
  end
end
