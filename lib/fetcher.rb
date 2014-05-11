require File.dirname(__FILE__) + "/boot.rb"

class Fetcher
  def fetch(url)
    page = Page.find_by_url(url)
    return [page.content, page.title] if page
    puts "from Web"
    html = open(url).read
    content, title = ExtractContent.analyse(html.toutf8)
    content = content.split(//u)[0..300].join + "..." if content.split(//u).size > 300
    Page.new(:url => url, :content => content, :title => title).save
    return [content, title]
  end

end

if __FILE__ == $0
  content, title = Fetcher.new.fetch("http://www.sinatrarb.com/intro-jp.html")
  puts title
end
