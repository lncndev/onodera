abstract class MainLayout
  include Lucky::HTMLPage

  # 'needs current_user : User' makes it so that the current_user
  # is always required for pages using MainLayout
  needs current_user : User

  abstract def content
  abstract def page_title

  # MainLayout defines a default 'page_title'.
  #
  # Add a 'page_title' method to your indivual pages to customize each page's
  # title.
  #
  # Or, if you want to require every page to set a title, change the
  # 'page_title' method in this layout to:
  #
  #    abstract def page_title : String
  #
  # This will force pages to define their own 'page_title' method.
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
      para do
        text "Logged in as "
        b current_user.email
      end
    end
  end

  private def render_signed_in_user
    text current_user.email
    text " - "
    link "Sign out", to: SignIns::Delete, flow_id: "sign-out-button"
  end
end
