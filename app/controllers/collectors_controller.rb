class CollectorsController < ApplicationController
  before_filter :find_collector_class_for_source, :only => [:new, :create]
  
  def index
    @collectors = ::Collector.all
  end

  def new
    @collector = @collector_class.new
  end
  
  def create
    @collector = @collector_class.new(params[:collector])
    if @collector.save
      redirect_to collectors_path, :notice => 'Collector was successfully created.'
    else
      render :action => "new"      
    end
  end

  def run
    collector = ::Collector.find(params[:id])
    collector.run # TODO Run via delayed_job (or similar solution)
    redirect_to collectors_path
  end
  
  private

  def find_collector_class_for_source
    source = params[:collector] && params[:collector][:source]
    @collector_class = ::Collector.collector_class_for(source)
    redirect_to collectors_path unless @collector_class
  end
end
