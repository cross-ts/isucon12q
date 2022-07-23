require 'new_relic/agent/method_tracer'

module ModuleNameHere
  class App < Sinatra::Base
    include ::NewRelic::Agent::MethodTracer

    add_method_tracer :db
    #add_method_tracer :method_name_here
  end
end
