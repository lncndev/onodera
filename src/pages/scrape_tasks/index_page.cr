class ScrapeTasks::IndexPage < MainLayout
  needs scrape_tasks : ScrapeTaskQuery
  quick_def page_title, "Scraping Queue"

  def content
    h1 "Scraping Queue"
    link "Add task to the queue", to: ScrapeTasks::New
    render_scrape_tasks
  end

  def render_scrape_tasks
    scrape_tasks.each do |scrape_task|
      link scrape_task.mal_id, ScrapeTasks::Index
    end
  end
end
