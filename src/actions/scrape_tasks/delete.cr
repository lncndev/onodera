class ScrapeTasks::Delete < BrowserAction
  delete "/scrape_tasks/:scrape_task_id" do
    scrape_task = ScrapeTaskQuery.find(scrape_task_id)
    DeleteScrapeTask.delete(scrape_task) do |_operation, _deleted|
      flash.success = "Deleted the scrape_task"
      redirect Index
    end
  end
end
