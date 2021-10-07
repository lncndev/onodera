class ScrapeTasks::New < BrowserAction
  get "/scrape/new" do
    html NewPage, operation: SaveScrapeTask.new
  end
end
