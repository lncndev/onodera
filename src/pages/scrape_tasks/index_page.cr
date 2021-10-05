class ScrapeTasks::IndexPage < MainLayout
  needs scrape_tasks : ScrapeTaskQuery
  quick_def page_title, "All ScrapeTasks"

  def content
    h1 "All ScrapeTasks"
    link "New ScrapeTask", to: ScrapeTasks::New
    render_scrape_tasks
  end

  def render_scrape_tasks
    ul do
      scrape_tasks.each do |scrape_task|
        li do
          link scrape_task.mal_id, ScrapeTasks::Show.with(scrape_task)
        end
      end
    end
  end
end
