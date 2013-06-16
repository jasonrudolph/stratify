module Stratify
  module Gowalla
    class Activity < Stratify::Activity
      field :checkin_id, :type => Integer
      field :spot_name
      field :spot_city_state
      field :spot_latitude, :type => BigDecimal
      field :spot_longitude, :type => BigDecimal
      field :message

      natural_key :checkin_id

      validates_presence_of :checkin_id, :spot_name, :spot_latitude, :spot_longitude

      template %q[
        <p class="summary">Checked in at <strong><%= spot_name %></strong> in <strong><%= spot_city_state %></strong></p>
        <p class="details"><%= message %></p>
      ]

      def permalink
        "http://gowalla.com/checkins/#{checkin_id}"
      end
    end
  end
end
