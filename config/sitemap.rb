# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://www.jiajiaone.com"

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end

  Teacher.find_each do |teacher|
    add detail_teachers_path(:id => teacher.number), :lastmod => teacher.updated_at, :priority => 1.0, :changefreq => 'always'
  end

  Notice.find_each do |notice|
    add notice_path(:id=>notice.number), :lastmod => notice.updated_at, :priority => 0.7, :changefreq => 'weekly'
  end

  Information.find_each do |information|
    add information_path(:id=>information.number), :lastmod => information.updated_at, :priority => 0.5, :changefreq => 'weekly'
  end
end
