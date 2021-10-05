class ScrapeTasks::Update < BrowserAction
  put "/scrape_tasks/:scrape_task_id" do
    scrape_task = ScrapeTaskQuery.find(scrape_task_id)
    SaveScrapeTask.update(scrape_task, params) do |operation, updated_scrape_task|
      if operation.saved?
        flash.success = "The record has been updated"
        redirect Show.with(updated_scrape_task.id)
      else
        flash.failure = "It looks like the form is not valid"
        html EditPage, operation: operation, scrape_task: updated_scrape_task
      end
    end
  end
end
