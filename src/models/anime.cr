class Anime < BaseModel
  table do
    column title : String
    column description : String?
    column image_url : String?
    column mal_id : String?
    column age_rating : String?
    column release : String?
    column episode_count : Int32?
  end
end