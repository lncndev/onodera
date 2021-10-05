class ScrapeTasks::NewPage < MainLayout
  needs operation : SaveScrapeTask
  quick_def page_title, "New ScrapeTask"

  def content
    h1 "New ScrapeTask"
    render_scrape_task_form(operation)
  end

  def render_scrape_task_form(op)
    form_for ScrapeTasks::Create do
      # Edit fields in src/components/scrape_tasks/form_fields.cr
      mount ScrapeTasks::FormFields, op

      submit "Save", data_disable_with: "Saving..."
    end
  end
end
