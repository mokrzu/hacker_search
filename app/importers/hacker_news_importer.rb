class HackerNewsImporter
  def import(pages=1)
    entries = RubyHackernews::Entry.all(pages)

    entries.each do |entry|
      create_or_update(entry)
    end
  end

  private
  
  def create_or_update(entry)
      article = Article.where( source_id: entry.id ).first_or_initialize

      if article.new_record?
        article.title = entry.link.title
        article.url = entry.link.href
        article.content = extract_content(entry.link.href)
        article.author = entry.user.name
        article.submitted_at = entry.time
        set_current_counters(article, entry)
      else
        set_current_counters(article, entry)
      end

      article.save
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