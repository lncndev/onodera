class Anime::IndexPage < MainLayout
  needs anime : AnimeQuery
  # needs pages : Lucky::Paginator
  quick_def page_title, "All Anime"

  def content
    h1 "All Anime"
    render_anime
  end

  def render_anime
    anime.each do |anime|
      h3 do
        link anime.title, Anime::Show.with(anime)
      end
    end
    # br; br
    # mount Lucky::Paginator::SimpleNav, pages
  end
end
