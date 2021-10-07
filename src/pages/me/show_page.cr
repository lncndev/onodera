class Me::ShowPage < MainLayout
  def content
    h1 "Kon'nichiwa!"
    para "(That's how we say \"hello\")", style: "font-size:10px;margin-top:-20px"
    search_form
    actions
  end

  private def actions
    h3 "What would you like to do?"
    h4 do
      link "Find Anime", Anime::Index; br
      link "Add Anime", Anime::New; br
      link "Scrape MAL to Onodera", ScrapeTasks::New
    end
  end

  private def search_form
    h4 "Search Anime"
    form_for Anime::Search do
      submit "Search", class: "btn btn-primary", style: "margin-bottom:-40px;margin-right:-54%"
      input name: "q", placeholder: "Bokutachi no Remake", class: "form-input", style: "max-width:50%"
    end
  end
end
