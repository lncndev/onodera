class ScrapeTasks::FormFields < BaseComponent
  needs operation : SaveScrapeTask

  def render
    mount Shared::Field, operation.mal_id, label_text: "Search Query", &.text_input(autofocus: "true")
  end
end
