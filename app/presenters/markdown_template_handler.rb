class MarkdownTemplateHandler
  def call(template, source)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)

    "#{markdown.render(template.source).inspect}.html_safe;"
  end
end