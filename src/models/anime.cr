class Anime < BaseModel
  table do
    column title : String
    column description : String
    column image_url : String
  end
end
