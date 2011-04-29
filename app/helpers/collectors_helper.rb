module CollectorsHelper
  def form_partial_for_source(source)
    "#{source.downcase}_form"
  end
end
