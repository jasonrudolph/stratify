require 'extensions/mongoid/natural_key'

class Activity
  include Mongoid::Document
  include Mongoid::Paranoia
  include Extensions::Mongoid::NaturalKey
  include Stratify::Renderable
  
  field :source, :type => String
  field :created_at, :type => DateTime

  validates_presence_of :created_at

  paginates_per 200

  def self.template(data = nil)
    super(data) || default_template
  end

  def self.default_template
    IO.read(default_template_path)
  end

  def self.default_template_path
    Rails.root.join('app', 'views', 'activities', default_template_filename)
  end

  def self.default_template_filename
    "_#{name.to_s.underscore}.html.#{template_format.to_s}"
  end

  def permalink
    nil
  end
  
  def created_on
    return nil unless created_at
    created_at.to_date
  end

  def duplicate?
    duplicate_activities = self.class.where(natural_key_hash)
    duplicate_activities.exists? || duplicate_activities.deleted.exists?
  end
end
