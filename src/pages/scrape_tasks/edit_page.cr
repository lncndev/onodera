class ScrapeTasks::EditPage < MainLayout
  needs operation : SaveScrapeTask
  needs scrape_task : ScrapeTask
  quick_def page_title, "Edit ScrapeTask with id: #{scrape_task.id}"

  def content
    link "Back to all ScrapeTasks", ScrapeTasks::Index
    h1 "Edit ScrapeTask with id: #{scrape_task.id}"
    render_scrape_task_form(operation)
  end

  def render_scrape_task_form(op)
    form_for ScrapeTasks::Update.with(scrape_task.id) do
      # Edit fields in src/components/scrape_tasks/form_fields.cr
      mount ScrapeTasks::FormFields, op

      submit "Update", data_disable_with: "Updating..."
    end
  end
end
