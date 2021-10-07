class Me::ShowPage < MainLayout
  def content
    h1 "Kon'nichiwa!"
    para "(That's how we say \"hello\")", style: "font-size:10px;margin-top:-20px"
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
end
