require 'redcarpet'

# set :relative_links, true # for deploying to /pacto

set :markdown_engine, :redcarpet
set :markdown, :fenced_code_blocks => true, :smartypants => true, :disable_indented_code_blocks => true, :prettify => true, :tables => true, :with_toc_data => true, :no_intra_emphasis => true
set :md, :layout_engine => :erb

helpers do
  def table_of_contents(resource)
    content = File.read(resource.source_file)
    content_without_frontmatter = content.gsub(/---.*?---\s*/m, '')
    toc_renderer = Redcarpet::Render::HTML_TOC.new
    markdown = Redcarpet::Markdown.new(toc_renderer, nesting_level: 2) # nesting_level is optional
    markdown.render(content_without_frontmatter)
  end
end

###
# Compass
###

# Change Compass configuration
compass_config do |config|
  config.add_import_path '../bower_components/foundation/scss'
end

ready do
  sprockets.append_path "../bower_components/foundation/js"
end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false

page 'robots.txt', :layout => false
page 'humans.txt', :layout => false

# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy (fake) files
# page "/this-page-has-no-template.html", :proxy => "/template-file.html" do
#   @which_fake_page = "Rendering a fake page with a variable"
# end

###
# Helpers
###

# On GitHub pages, pacto is served as a subdirectory (thoughtworks.github.io/pacto)
set :build_dir, 'public/pacto'
set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'

activate :navigation

# Build-specific configuration
configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :minify_html
  activate :bourbon

  # Enable cache buster
  # activate :cache_buster

  # Use relative URLs
  # activate :relative_assets

  # Compress PNGs after build
  # First: gem install middleman-smusher
  # require "middleman-smusher"
  # activate :smusher

  # Or use a different image path
  set :http_prefix, "/pacto/"
  # set :http_prefix, "/pacto/"
end

# Middleman Blog
# Time.zone = "UTC"
activate :blog do |blog|
  blog.prefix = "blog"
  blog.permalink = "{year}/{month}/{day}/{title}.html"
  blog.sources = "{year}-{month}-{day}-{title}.html"
  blog.taglink = "tags/{tag}.html"
  blog.layout = "article"
  blog.summary_separator = /(READMORE)/
  blog.summary_length = 250
  blog.year_link = "{year}.html"
  blog.month_link = "{year}/{month}.html"
  blog.day_link = "{year}/{month}/{day}.html"
  blog.default_extension = ".md"

  blog.tag_template = "/blog/tag.html"
  blog.calendar_template = "/blog/calendar.html"

  blog.paginate = true
  blog.per_page = 5
  blog.page_link = "page/{num}"
end

page "/blog/feed.xml", :layout => false

# Middleman Deploy
activate :deploy do |deploy|
  deploy.method = :git
  deploy.remote = 'origin'
  deploy.branch = 'gh-pages'
  deploy.clean = true
end

activate :directory_indexes
page "/404.html", :directory_index => false

activate :syntax #, :line_numbers => true

activate :livereload
