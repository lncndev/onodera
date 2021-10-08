abstract class AuthLayout
  include Lucky::HTMLPage

  abstract def content
  abstract def page_title

  # The default page title. It is passed to `Shared::LayoutHead`.
  #
  # Add a `page_title` method to pages to override it. You can also remove
  # This method so every page is required to have its own page title.
  def page_title
    "Onodera"
  end

  def render
    head do
      if page_title != "Onodera"
        title page_title + " | Onodera \"" + ENV["ONODERA_VERSION_NAME"] + "\""
      else
        title "Onodera \"" + ENV["ONODERA_VERSION_NAME"] + "\""
      end
      css_link asset("css/app.css"), data_turbolinks_track: "reload"
    end
    tag "center" do
      h1 style: "font-size:150px;font-family:Sacramento;margin-top:1rem" do
        # img height: "100px", src: "/assets/images/logo/512.png", style: "margin-top:-3rem", width: "100px"
        text "onodera"
      end
      h3 style: "margin-top:-65px" do
        a href: "/" do
          i class: "mdi mdi-home"
        end
        a href: "/auth" do
          i class: "mdi mdi-login"
        end
      end
      br
      content
      br
      br
      br
      para do
        b "Onodera"
        text " v" + ENV["ONODERA_VERSION_NUMBER"] + " \"" + ENV["ONODERA_VERSION_NAME"] + "\""
        br
        text "Made with <3 and Crystal - AGPLv3 - "
        a "Github", href: "https://github.com/onoderaproject"
      end
    end
  end
end
