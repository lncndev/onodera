class ScrapeTasks::NewPage < MainLayout
  needs operation : SaveScrapeTask
  quick_def page_title, "Add scraping task to the queue"

  def content
    h1 "Add scraping task to the queue"
    render_scrape_task_form(operation)
  end

  def render_scrape_task_form(op)
    form_for ScrapeTasks::Create do
      # Edit fields in src/components/scrape_tasks/form_fields.cr
      mount ScrapeTasks::FormFields, op
      br
      submit "Add to queue", data_disable_with: "Saving...", class: "btn btn-primary"
    end
  end
end
