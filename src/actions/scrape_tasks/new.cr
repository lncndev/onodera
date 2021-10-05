class ScrapeTasks::New < BrowserAction
  get "/scrape_tasks/new" do
    html NewPage, operation: SaveScrapeTask.new
  end
end
