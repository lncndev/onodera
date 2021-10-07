class Init::V20211006131253 < Avram::Migrator::Migration::V1
  def migrate
    # Read more on migrations
    # https://www.luckyframework.org/guides/database/migrations
    #
    # create table_for(Thing) do
    #   primary_key id : Int64
    #   add_timestamps
    #
    #   add title : String
    #   add description : String?
    # end

    # Run custom SQL with execute
    #
    # execute "CREATE UNIQUE INDEX things_title_index ON things (title);"

    create table_for(Anime) do
      primary_key id : Int64
      add_timestamps

      add title : String
      add description : String?, default: "No description provided."
      add image_url : String?
      add mal_id : String?
    end

    create table_for(User) do
      primary_key id : Int64
      add_timestamps

      add email : String
      add username : String?
      add encrypted_password : String
    end

    create table_for(ScrapeTask) do
      primary_key id : Int64
      add_timestamps

      add mal_id : String
      add_belongs_to user : User, on_delete: :cascade
    end
  end

  def rollback
    # drop table_for(Thing)
  end
end
