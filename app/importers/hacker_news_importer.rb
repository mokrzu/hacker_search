class HackerNewsImporter
  def import(pages=1)
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
      article.submitted_at = entry.time
    end

    set_current_counters(article, entry)
  end

  def set_current_counters(article, entry)
    article.points = entry.voting.score
    article.comments_count = entry.comments_count
  end

  def extract_content(url)
    begin
      result = JSON.load(Boilerpipe.extract(url, {:output => :json}))
    rescue JSON::ParserError
      return ""
    rescue TypeError
      return ""
    end

    if result["status"] == "success"
      result['response']['content']
    else
      ""
    end
  end
end