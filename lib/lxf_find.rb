module LxfFind
  def self.find_inside(local_pages,query=nil)
    puts "What do you search?:"
    unless query
      query = STDIN::gets.chomp
    end
    puts "====================\n"
    local_pages.each do |page|
      filename= LOCAL_DIR + page
      html_source = open(filename).read
      if html_source.include?(query) or html_source.include?(query.upcase) or html_source.include?(query.capitalize)
        puts "LinuxFormat#" + /\d{2,3}/.match(page)[0] + "\n"
      end
    end
    puts "====================\n"
  end
end
