module CollectorsHelper
  def form_url_for(collector)
    collector.persisted? ? collector_path(collector) : collectors_path
  end
end
