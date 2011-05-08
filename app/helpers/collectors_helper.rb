module CollectorsHelper
  def form_url_for(collector)
    collector.persisted? ? collector_path(collector) : collectors_path
  end
  
  def form_partial_for_source(source)
    "#{source.downcase}_form"
  end
end
