class ScrapeTasks::Create < BrowserAction
  post "/scrape" do
    SaveScrapeTask.create(mal_id: JSON.parse(Jikan.search("anime", params.from_form_data["scrape_task:mal_id"].to_s.gsub(" ", "+")).to_s)["results"][0]["mal_id"].to_s) do |operation, scrape_task|
      if scrape_task
        flash.success = "Added to queue"
        redirect New
      else
        flash.failure = "It looks like the form is not valid"
        html NewPage, operation: operation
      end
    end
  end
end
