module LxfFind
  def self.find_inside(local_pages, query = nil)
    unless query
      puts "What do you search?:"
      query = STDIN::gets.chomp
    else
      puts "Search for #{query}:"
    end
    puts "====================\n"
    local_pages.each do |page|
	  html = Nokogiri::HTML(open(LOCAL_DIR + page.to_s))
	  node_anons = html.css('.node-anons')
	  text = node_anons.empty? ? html.css('body').text : node_anons.text
	  puts "LinuxFormat##{page}\n" if text.match(/#{query}/i)
    end
    puts "====================\n"
  end

  def self.extract_links(url, method, headers)
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
