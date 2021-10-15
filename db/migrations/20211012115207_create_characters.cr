class CreateCharacters::V20211012115207 < Avram::Migrator::Migration::V1
  def migrate
    # Learn about migrations at: https://luckyframework.org/guides/database/migrations
    create table_for(Character) do
      primary_key id : Int64
      add_timestamps
      add name : String
      add bio : String?
      add image_url : String?
      add mal_id : String?

      add_belongs_to source : Anime?, on_delete: :cascade
    end
  end

  def rollback
    drop table_for(Character)
  end
end
