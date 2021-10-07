require "mosquito"
require "redis"
require "jikancr"

class ScrapingTask < Mosquito::PeriodicJob
  run_every 4.seconds

  def perform
    scrape_task = ScrapeTaskQuery.new.first

    mal_data = Jikan.anime(scrape_task.mal_id.to_s)
    SaveAnime.create(title: mal_data["title"].to_s, description: mal_data["synopsis"].to_s.gsub("—", "---"), image_url: mal_data["image_url"].to_s, mal_id: mal_data["mal_id"].to_s) do |scrape_task|; end

    DeleteScrapeTask.delete(scrape_task) do |operation, deleted_scrape_task|; end
  end
end

spawn do
  Mosquito::Runner.start
end
