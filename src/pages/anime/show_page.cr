class Anime::ShowPage < MainLayout
  needs anime : Anime
  quick_def page_title, anime.title + " (Anime)"

  def content
    link "Back to all anime", Anime::Index
    br; br

    img src: anime.image_url, style: "max-height:300px"
    h1 anime.title
    render_anime_fields

    br
    render_actions
  end

  def render_actions
    section do
      link "Edit", Anime::Edit.with(anime.id)
      text " | "
      link "Delete",
        Anime::Delete.with(anime.id),
        data_confirm: "Are you sure?"
    end
  end

  def render_anime_fields
    para anime.description.to_s, style: "max-width:70%"
  end
end
