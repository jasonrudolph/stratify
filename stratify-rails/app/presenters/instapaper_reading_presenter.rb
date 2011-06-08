class InstapaperReadingPresenter
  delegate :url, :title, :description, :to => :@activity
  
  def initialize(activity)
    @activity = activity
  end

  def summary
    title.blank? ? url : title
  end

  def details
    join_fields_with_separator domain, description
  end

  def domain
    URI.parse(url).host
  end
  
  private
  
  def separator
    "\u2022"
  end
  
  def join_fields_with_separator(*fields)
    fields.reject(&:blank?).join(" #{separator} ")
  end
end
