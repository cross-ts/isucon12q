require 'new_relic/agent/method_tracer'

module ModuleNameHere
  class App < Sinatra::Base
    include ::NewRelic::Agent::MethodTracer

    add_method_tracer :connect_admin_db
    add_method_tracer :admin_db
    add_method_tracer :tenant_db_path
    add_method_tracer :connect_to_tenant_db
    add_method_tracer :create_tenant_db
    add_method_tracer :dispense_id
    add_method_tracer :parse_viewer
    add_method_tracer :retrieve_tenant_row_from_header
    add_method_tracer :retrieve_player
    add_method_tracer :authorize_player!
    add_method_tracer :retrieve_competition
    add_method_tracer :lock_file_path
    add_method_tracer :flock_by_tenant_id
    add_method_tracer :validate_tenant_name
    add_method_tracer :billing_report_by_competition
    add_method_tracer :competitions_handler
  end
end
