class PunchCardGraphPresenter
  attr_reader :source

  def initialize(source, activities)
    @source = source
    @activities = activities
  end

  def url
    graph_builder.to_url
  end

  private

  def graph_builder
    timestamps = @activities.map(&:created_at)
    PunchCardGraph::Builder.new(:timestamps => timestamps)
  end
end
