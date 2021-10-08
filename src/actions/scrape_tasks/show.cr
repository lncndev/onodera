class ScrapeTasks::Show < BrowserAction
  get "/scrape/:scrape_task_id" do
    html ShowPage, scrape_task: ScrapeTaskQuery.find(scrape_task_id)
  end
end
