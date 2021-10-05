class ScrapeTasks::FormFields < BaseComponent
  needs operation : SaveScrapeTask

  def render
    mount Shared::Field, operation.mal_id, &.text_input(autofocus: "true")
  end
end
