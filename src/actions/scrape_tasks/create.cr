class ScrapeTasks::Create < BrowserAction
  post "/scrape_tasks" do
    SaveScrapeTask.create(params) do |operation, scrape_task|
      if scrape_task
        flash.success = "The record has been saved"
        redirect Show.with(scrape_task.id)
      else
        flash.failure = "It looks like the form is not valid"
        html NewPage, operation: operation
      end
    end
  end
end
