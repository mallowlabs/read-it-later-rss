require File.dirname(__FILE__) + "/boot.rb"

class Fetcher
  def fetch(url)
    page = Page.find_by_url(url)
    return [page.content, page.title] if page
    puts "from Web"
    extractor = ExtractContent::Extractor.new
    html = open(url).read
    content, title = extractor.analyse(html).map { |t| t.toutf8 }
    Page.new(:url => url, :content => content, :title => title).save
    return [content, title]
  end

end

if __FILE__ == $0
  content, title = Fetcher.new.fetch("http://www.sinatrarb.com/intro-jp.html")
  puts title
end
