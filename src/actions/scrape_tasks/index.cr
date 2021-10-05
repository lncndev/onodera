class ScrapeTasks::Index < BrowserAction
  get "/scrape_tasks" do
    html IndexPage, scrape_tasks: ScrapeTaskQuery.new
  end
end
