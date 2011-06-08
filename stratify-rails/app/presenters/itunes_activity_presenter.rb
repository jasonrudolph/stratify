class ItunesActivityPresenter
  def initialize(activity)
    @activity = activity
  end

  def name
    @activity.name.blank? ? 'Untitled' : @activity.name
  end

  def summary
    return name if movie?
    join_fields_with_separator name, artist
  end

  def details
    if tv_show?
      join_fields_with_separator season_number, episode_number, year
    else
      join_fields_with_separator album, year, genre
    end
  end
  
  def season_number
    return unless @activity.season_number
    "Season #{@activity.season_number}"
  end

  def episode_number
    number = @activity.episode_number || @activity.track_number
    return unless number
    "Episode #{number}"
  end
  
  def method_missing(*args)
    @activity.send(*args)
  end
  
  private

  def separator
    "\u2022"
  end
  
  def join_fields_with_separator(*fields)
    fields.reject(&:blank?).join(" #{separator} ")
  end
end
