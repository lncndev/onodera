class Anime::SearchPage < MainLayout
  needs anime : AnimeQuery
  quick_def page_title, "All Anime"

  def content
    h1 "All Anime"
    link "Add Anime", to: Anime::New
    render_anime
  end

  def render_anime
    ul do
      anime.each do |anime|
        li do
          link anime.title, Anime::Show.with(anime)
        end
      end
    end
  end
end
