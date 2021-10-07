class Home::IndexPage < AuthLayout
  def content
    h1 do
      b do
        text "Modern. Open. Beautiful."
      end
    end
    h2 do
      text "An anime and manga database "
      u do
        text "by weebs for weebs"
      end
      text "."
    end
    br
    para do
      text "Onodera is a free, open source anime and manga database similar to MAL but modern, open, fast, and beautiful."
      br
      text "Written in Crystal. Built on Lucky."
    end
    br
    link to: SignUps::New do
      button "Sign up", class: "btn btn-primary", style: ""
    end
    br; br
    para style: "font-size:10px" do
      text "An account is required at this time. This requirement will be lifted once we get better spam protection set up."
    end
  end
end
