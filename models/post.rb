class Post

  attr_reader :title, :date, :text

  def initialize(args)
    @title = args[:title]
    @date  = args[:date]
    @text  = args[:text]
  end

  def title_url
    @title_url ||= title.downcase.gsub(/\s+/, '_').gsub(/\W/, '')
  end

  def self.match(title_url)
    all.find do |post|
      post.title_url == title_url
    end
  end

  def self.all
    return @@all if defined?(@@all) && ENV["RACK_ENV"] == "production"
    @@all = posts.map do |post|
      split = post.strip.split "\n"
      title = split[0].sub(/^#/, '').strip
      date  = split[1].strip
      text  = split[2..-1].join("\n").strip
      text  = RDiscount.new(text).to_html
      Post.new title: title, date: date, text: text
    end

  end

  def self.posts
    markdown = File.read "#{PATH}/views/posts.md"
    markdown.split("---")
  end

end