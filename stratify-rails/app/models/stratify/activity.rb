module Stratify
  class Activity
    include Kaminari::MongoidExtension::Document
    paginates_per 200
  end
end
