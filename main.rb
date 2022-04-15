require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'json'
  gem 'influxdb'
  gem 'byebug'
end

# Change these hosts to match your environment
influxdb_host  = '192.168.0.4'
connector_host = '192.168.0.5'

database = 'metrics'
name     = 'connector'

influxdb = InfluxDB::Client.new host: influxdb_host, database: database

loop do
  begin
    response = Net::HTTP.get_response(connector_host,'/api/1/vitals')
    body = JSON.parse(response.body, symbolize_names: true)

    data = {
      values: {
        vehicle_connected:  body[:vehicle_connected] ? 1 : 0,
        vehicle_current_a:  body[:vehicle_current_a],
        currentA_a:         body[:currentA_a],
        currentB_a:         body[:currentB_a],
        currentC_a:         body[:currentC_a],
        voltageA_v:         body[:voltageA_v],
        voltageB_v:         body[:voltageB_v],
        voltageC_v:         body[:voltageC_v],
        grid_v:             body[:grid_v],
        grid_hz:            body[:grid_hz],
        handle_temp_c:      body[:handle_temp_c],
        mcu_temp_c:         body[:mcu_temp_c],
        pcba_temp_c:        body[:pcba_temp_c],
        energy_wh:          body[:session_energy_wh]
      }
    }

    resp = influxdb.write_point(name, data)
  rescue Exception => e
    puts "Error: #{e}"
  end

  sleep 10
end
