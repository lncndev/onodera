class ScrapeTasks::Edit < BrowserAction
  get "/scrape_tasks/:scrape_task_id/edit" do
    scrape_task = ScrapeTaskQuery.find(scrape_task_id)
    html EditPage,
      operation: SaveScrapeTask.new(scrape_task),
      scrape_task: scrape_task
  end
end
