class SaveAnime < Anime::SaveOperation
  # To save user provided params to the database, you must permit them
  # https://luckyframework.org/guides/database/saving-records#perma-permitting-columns
  permit_columns title, description, image_url, mal_id, age_rating, release, episode_count
end