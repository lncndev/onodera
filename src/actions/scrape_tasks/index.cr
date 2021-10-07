class ScrapeTasks::Index < BrowserAction
  get "/scrape" do
    html IndexPage, scrape_tasks: ScrapeTaskQuery.new
  end
end
