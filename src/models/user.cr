class User < BaseModel
  include Carbon::Emailable
  include Authentic::PasswordAuthenticatable

  table do
    column email : String
    column username : String?
    column encrypted_password : String

    has_many scrape_task : ScrapeTask
  end

  def emailable : Carbon::Address
    Carbon::Address.new(email)
  end
end
