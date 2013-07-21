class CollectorsController < ApplicationController
  before_filter :find_collector_class_for_source, :only => [:new, :create]

  def index
    @collectors = Stratify::Collector.asc(:source)
  end

  def new
    @collector = @collector_class.new
  end

  def edit
    @collector = Stratify::Collector.find(params[:id])
  end

  def create
    @collector = @collector_class.new(collector_params(@collector_class))
    if @collector.save
      redirect_to collectors_path, :notice => 'Collector was successfully created.'
    else
      render :action => "new"
    end
  end

  def update
    @collector = Stratify::Collector.find(params[:id])

    if @collector.update_attributes(collector_params(@collector.class))
      redirect_to collectors_path, :notice => 'Collector was successfully updated.'
    else
      render :action => "edit"
    end
  end

  def destroy
    @collector = Stratify::Collector.find(params[:id])
    @collector.delete
    redirect_to collectors_path
  end

  def run
    collector = Stratify::Collector.find(params[:id])
    collector.run # TODO Run via delayed_job (or similar solution)
    redirect_to collectors_path
  end

  private

  def find_collector_class_for_source
    source = params[:collector] && params[:collector][:source]
    @collector_class = Stratify::Collector.collector_class_for(source)
    redirect_to collectors_path unless @collector_class
  end

  def collector_params(collector_class)
    permitted_params = collector_configuration_field_names(collector_class)
    params.require(:collector).permit(*permitted_params)
  end

  def collector_configuration_field_names(collector_class)
    collector_class.configuration_fields.map(&:name)
  end
end
