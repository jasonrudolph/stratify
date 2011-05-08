class CollectorsController < ApplicationController
  before_filter :find_collector_class_for_source, :only => [:new, :create]
  
  def index
    @collectors = ::Collector.asc(:source)
  end

  def new
    @collector = @collector_class.new
  end

  def edit
    @collector = ::Collector.find(params[:id])
  end
  
  def create
    @collector = @collector_class.new(params[:collector])
    if @collector.save
      redirect_to collectors_path, :notice => 'Collector was successfully created.'
    else
      render :action => "new"      
    end
  end

  def update
    @collector = ::Collector.find(params[:id])

    if @collector.update_attributes(params[:collector])
      redirect_to collectors_path, :notice => 'Collector was successfully updated.'
    else
      render :action => "edit"
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
