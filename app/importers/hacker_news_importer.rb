class HackerNewsImporter
  def import(pages=1)
    @http_agent = Mechanize.new
    entries = RubyHackernews::Entry.all(pages)

    entries.each do |entry|
      save_entry(entry)
    end
  end

  private

  def save_entry(entry)
    article = Article.where( source_id: entry.id ).first_or_initialize
    create_or_update(article, entry)
    article.save
  end

  def create_or_update(article, entry)
    if article.new_record?
      article.title = entry.link.title
      article.url = entry.link.href
      article.content = extract_content(entry.link.href)
      article.author = entry.user.name
      article.submitted_at = secure_time_extraction(entry)
    end

    set_current_counters(article, entry)
  end

  def set_current_counters(article, entry)
    article.points = entry.voting.score
    article.comments_count = entry.comments_count
  end

  def secure_time_extraction(entry)
    entry.time
  rescue NoMethodError
    nil
  end

  def extract_content(url)
    source = @http_agent.get(url).content
    Readability::Document.new(source, tags: [], encoding: "UTF-8")
                            .content
                            .gsub(/(\s+)|\n/, " ")

  rescue ArgumentError => exception
    if exception.message.include?("UTF-8")
      return ""
    else
      raise
    end
  rescue Mechanize::ResponseCodeError
    return ""
  end
end