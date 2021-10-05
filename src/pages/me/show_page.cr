class Me::ShowPage < MainLayout
  def content
    h1 "Hello, #{@current_user.username}!"
    actions
  end

  private def actions
    h3 "What would you like to do?"
    h4 do
      link "Find Anime", Anime::Index; br
      link "Add Anime", Anime::New;br
      link "Scrape MAL to Onodera", ScrapeTasks::New
    end
  end
end
