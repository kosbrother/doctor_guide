# encoding: utf-8
module Crawler

  require 'nokogiri'
  require 'open-uri'
  require 'net/http'

  attr_accessor :page_url, :page_html, :fake_browser_urls, :do_not_encode_urls, :match_url_pattern, :url_host, :url_path, :url_query, :url_proto, :url_path_without_tail

  def parse_url url
    /^((http[s]?|ftp):\/)?\/?([^:\/\s]+)((\/\w+)*\/)([\w\-\.]+[^#?\s]+)(.*)?(#[\w\-]+)?$/ =~ url
    @url_proto = $2
    @url_host = $3
    if $6.nil? || $6.include?('html')
      @url_path = $4
    else
      @url_path = $4 + $6
    end
    @url_path_without_tail = $4
    @url_query = $7
  end

  def get_url href
    return href unless href.present?
    if href.start_with?("http")
      href
    elsif href.start_with?("/")
      @url_proto + "://" + @url_host + href
    elsif href.include? "html"
      @url_proto + "://" + @url_host + @url_path + href + @url_query
    else
      @url_proto + "://" + @url_host + @url_path_without_tail + href
    end
  end

  def fetch url
    @fake_browser_urls = ['00xs.com','www.7788xiaoshuo.com',"book.rijigu.com","yueduxs.com","b.faloo.com","www.ttzw.com","www.8535.org","6ycn.net","www.readnovel.com","www.d586.com","www.fftxt.com","www.bixiage.com"]
    @do_not_encode_urls = ['ixs.cc','quledu.com','tw.xiaoshuokan.com','7788xiaoshuo.com','wcxiaoshuo.com','2dollars.com.tw','dushi800','59to.org','book.sfacg','ranwenba','shushu5','kushuku','feiku.com','daomubiji','luoqiu.com','kxwxw','txtbbs.com','tw.57book','b.faloo.com/p/','9pwx.com']
    @page_url = url
    get_page(@page_url)
  end

  def fetch_without_nokogiri url
    @page_url = url
    body = ''
    begin
      open(url){ |io|
        body = io.read
      }
    rescue
    end
    @page_html = body
  end

  def post_fetch url, option
    parse_url url
    @page_url = url
    url = URI.parse(url)
    resp, data = Net::HTTP.post_form(url, option)
    @page_html = Nokogiri::HTML(resp.body)
  end

  def get_page url

    @page_url = url
    body = ''
    begin
      open(url){ |io|
        body = io.read
      }
    rescue
    end

    if isNeedFakeBrowserUrl(url)
      /#{@match_url_pattern}(.*)/ =~ url
      url = $1
      http = Net::HTTP.new(@match_url_pattern, 80)
      res = http.get url, 'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_8) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.162 Safari/535.19', 'Cookie' => '_ts_id=360435043104370F39'
      content = res.body
      get_nokogiri_html(content)
    elsif isDoNotNeedReEncodeUrl(url)
      @page_html = Nokogiri::HTML(body)
    else
      get_nokogiri_html(body)
    end

    parse_url url
    @page_html
  end

  def get_nokogiri_html body
    tmp = body.encode("utf-8", :undef => :replace, :replace => "?", :invalid => :replace)
    @page_html = Nokogiri::HTML(tmp)
    encoding = @page_html.meta_encoding

    if(encoding == "gbk" || encoding == "gb2312")
      body.force_encoding("gbk")
      body.encode!("utf-8", :undef => :replace, :replace => "", :invalid => :replace)
      @page_html = Nokogiri::HTML.parse body
    elsif(encoding == "big5")
      body.force_encoding("big5")
      body.encode!("utf-8", :undef => :replace, :replace => "", :invalid => :replace)
      @page_html = Nokogiri::HTML(body,nil)
    else
      # some need encode, some needn't , need check
      @page_html = Nokogiri::HTML(body)
    end
  end

  def isDoNotNeedReEncodeUrl(url)
    @do_not_encode_urls.each do |check_pattern|
      return true if url.index(check_pattern)
    end
    return false
  end

  def isNeedFakeBrowserUrl(url)
    @fake_browser_urls.each do |check_pattern|
      if url.index(check_pattern)
        @match_url_pattern = check_pattern
        return true
      end
    end
    return false
  end

  def get_item_href dns, src
    if (/^\/\// =~ src)
      src = "http:" + src
    elsif (/^\// =~ src)
      src = dns + src
    elsif (/\.\./ =~ src)
      src = dns + src[2..src.length]
    else
      src
    end
  end

  def parse_dns
    url_scan = @page_url.scan(/.*?\//)
    dns = url_scan[0] + url_scan[1] + url_scan[2]
  end

  def change_node_br_to_newline node
    content = node.to_html
    content = content.gsub("<br>","\n")
    n = Nokogiri::HTML(content)
    n.text
  end

  def isArticleTextOK article,text
    return true unless article.is_show if article
    article != nil && text != nil && (text.size > 80 || text.index('.gif') || text.index('.jpg') || text.index('.png'))
  end

  def set_novel_last_update_and_num(novel_id)
    novel = Novel.find(novel_id)
    if novel.articles.show.last
      time = novel.articles.show.last.created_at.strftime("%y-%m-%d")
      novel.last_update = time
      novel.article_num = novel.articles.show.size.to_s + "篇"
      novel.save
    end
  end


end
