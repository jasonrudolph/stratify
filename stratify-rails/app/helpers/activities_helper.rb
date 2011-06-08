module ActivitiesHelper
  def css_class_for_activity(activity)
    activity.source.downcase
  end
  
  def image_tag_for_activity(activity)
    source = activity.source.downcase
    image_tag("icons/#{source}-icon-24.png", :alt => "#{source} icon")
  end
end
