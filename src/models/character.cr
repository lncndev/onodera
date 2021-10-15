class Character < BaseModel
  table do
    column name : String
    column bio : String?
    column image_url : String?
    column mal_id : String?

    belongs_to source : Anime?
  end
end
