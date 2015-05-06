module LxfFind
  def self.find_inside(local_pages, query = nil)
    unless query
      puts "What do you search?:"
      query = STDIN::gets.chomp
    else
      puts query
    end
    puts "====================\n"
    local_pages.each do |page|
      filename= LOCAL_DIR + page.to_s
      html_source = open(filename).read
      if html_source.include?(query) or html_source.include?(query.upcase) or html_source.include?(query.capitalize)
        puts "LinuxFormat##{page}\n"
      end
    end
    puts "====================\n"
  end
  def self.extract_links(url, method, headers = {"User-Agent" => "Ruby #{RUBY_VERSION}"})
    case method
    when 'local'
      archive_page = open(url)
    when 'online'
      archive_page = open(url, headers)
    end
    page = Nokogiri::HTML(archive_page)
    links = page.css('div.b-anons-cover a').map do |a|
      link = a['href']
      /\d{2,3}/.match(link)[0].to_i
    end
    return links
  end
end
