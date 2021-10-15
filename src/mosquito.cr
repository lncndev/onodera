require "mosquito"
require "redis"
require "jikancr"
require "./app"

class ScrapingTask < Mosquito::PeriodicJob
  run_every 4.seconds

  def perform
    scrape_task = ScrapeTaskQuery.new.first

    mal_data = Jikan.anime(scrape_task.mal_id.to_s)
    SaveAnime.create(title: mal_data["title"].to_s, description: mal_data["synopsis"].to_s.gsub("—", "---"), image_url: mal_data["image_url"].to_s, mal_id: mal_data["mal_id"].to_s, age_rating: mal_data["rating"].to_s, release: mal_data["premiered"].to_s, episode_count: mal_data["episodes"].to_s.to_i) do |scrape_task|; end

    DeleteScrapeTask.delete(scrape_task) do |operation, deleted_scrape_task|; end
  end
end

class BuildYAMLDataset < Mosquito::PeriodicJob
  run_every 1.hour

  def perform
    File.write("data.yaml", build_yaml_string)
  end

  private def build_yaml_string
    yaml_string = YAML.build do |yaml|
      yaml.mapping do
        yaml.scalar "anime"
        yaml.sequence do
          AnimeQuery.new.each do |anime|
            yaml.mapping do
              yaml.scalar anime.id
              yaml.mapping do
                yaml.scalar "title"
                yaml.scalar anime.title.to_s
              end
              yaml.mapping do
                yaml.scalar "description"
                yaml.scalar anime.description.to_s
              end
              yaml.mapping do
                yaml.scalar "image_url"
                yaml.scalar anime.image_url.to_s
              end
              yaml.mapping do
                yaml.scalar "mal_id"
                yaml.scalar anime.mal_id.to_s
              end
              yaml.mapping do
                yaml.scalar "age_rating"
                yaml.scalar anime.age_rating.to_s
              end
              yaml.mapping do
                yaml.scalar "release"
                yaml.scalar anime.release.to_s
              end
              yaml.mapping do
                yaml.scalar "episode_count"
                yaml.scalar anime.episode_count.to_s
              end
            end
          end
        end
      end
    end

    yaml_string.to_s
  end
end

spawn do
  Mosquito::Runner.start
end
