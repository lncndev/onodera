class Docs::ShowPage < MainLayout
  def content
    div style: "text-align:left;max-width:70%" do
      raw Markd.to_html(File.read("./DOCS.md"))
    end
  end
end
