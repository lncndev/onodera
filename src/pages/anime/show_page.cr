class Anime::ShowPage < MainLayout
  needs anime : Anime
  quick_def page_title, anime.title + " (Anime)"

  def content
    link "Back to all anime", Anime::Index
    br; br

    if anime.image_url.to_s.empty? != true
      img src: HTML.escape(anime.image_url.to_s), style: "max-height:300px"
    end
    br; br
    h1 HTML.escape(anime.title.to_s)
    render_anime_fields

    br
    render_actions
  end

  def render_actions
    section do
      link "Edit", Anime::Edit.with(anime.id)
    end
  end

  def render_anime_fields
    para HTML.escape(anime.description.to_s), style: "max-width:70%"
  end
end
