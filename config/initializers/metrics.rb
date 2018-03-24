INFLUXDB_CLIENT = InfluxDB::Client.new 'metrics', host: 'localhost', time_precision: 'ms'

ActiveSupport::Notifications.subscribe('process_action.action_controller') do |*args|
  event = ActiveSupport::Notifications::Event.new(*args)
  INFLUXDB_CLIENT.write_point('process_action.action_controller', {
    values: { value: event.duration},
    tags: { controller: event.payload[:controller], status: event.payload[:status] }
  })
end
