class ScrapeTasks::ShowPage < MainLayout
  needs scrape_task : ScrapeTask
  quick_def page_title, "ScrapeTask with id: #{scrape_task.id}"

  def content
    link "Back to all ScrapeTasks", ScrapeTasks::Index
    h1 "ScrapeTask with id: #{scrape_task.id}"
    render_actions
    render_scrape_task_fields
  end

  def render_actions
    section do
      link "Edit", ScrapeTasks::Edit.with(scrape_task.id)
      text " | "
      link "Delete",
        ScrapeTasks::Delete.with(scrape_task.id),
        data_confirm: "Are you sure?"
    end
  end

  def render_scrape_task_fields
        text scrape_task.mal_id.to_s
      end
  end