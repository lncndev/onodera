class Anime::SearchPage < MainLayout
  needs anime : AnimeQuery
  needs query : String
  quick_def page_title, "All Anime"

  def content
    h1 "Anime for \"#{query}\""
    render_anime
  end

  def render_anime
    anime.each do |anime|
      h3 do
        link anime.title, Anime::Show.with(anime)
      end
    end
  end
end
