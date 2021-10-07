class ScrapeTasks::ShowPage < MainLayout
  needs scrape_task : ScrapeTask
  quick_def page_title, "ScrapeTask with id: #{scrape_task.id}"

  def content
    link "Back to scraping queue", ScrapeTasks::Index
    h1 "Scraping task ##{scrape_task.id}"
    render_scrape_task_fields
    render_actions
  end

  def render_actions
    section do
      link "Cancel task",
        ScrapeTasks::Delete.with(scrape_task.id),
        data_confirm: "Are you sure?"
    end
  end

  def render_scrape_task_fields
    h2 scrape_task.mal_id.to_s
  end
end
