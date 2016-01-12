##
# This code was generated by
# \ / _    _  _|   _  _
#  | (_)\/(_)(_|\/| |(/_  v1.0.0
#       /       /       

module Twilio
  module REST
    class Api < Domain
      class V2010 < Version
        class AccountContext < InstanceContext
          class QueueContext < InstanceContext
            class MemberList < ListResource
              ##
              # Initialize the MemberList
              def initialize(version, account_sid: nil, queue_sid: nil)
                super(version)
                
                # Path Solution
                @solution = {
                    account_sid: account_sid,
                    queue_sid: queue_sid
                }
                @uri = "/Accounts/#{@solution[:account_sid]}/Queues/#{@solution[:queue_sid]}/Members.json"
              end
              
              ##
              # Reads MemberInstance records from the API as a list.
              def list(limit: nil, page_size: nil)
                self.stream(
                    limit: limit,
                    page_size: page_size
                ).entries
              end
              
              def stream(limit: nil, page_size: nil)
                limits = @version.read_limits(limit, page_size)
                
                page = self.page(
                    page_size: limits['page_size'],
                )
                
                @version.stream(page, limit: limits['limit'], page_limit: limits['page_limit'])
              end
              
              def each
                limits = @version.read_limits
                
                page = self.page(
                    page_size: limits['page_size'],
                )
                
                @version.stream(page,
                                limit: limits['limit'],
                                page_limit: limits['page_limit']).each {|x| yield x}
              end
              
              ##
              # Retrieve a single page of MemberInstance records from the API.
              def page(page_token: nil, page_number: nil, page_size: nil)
                params = {
                    'PageToken' => page_token,
                    'Page' => page_number,
                    'PageSize' => page_size,
                }
                response = @version.page(
                    'GET',
                    @uri,
                    params
                )
                return MemberPage.new(
                    @version,
                    response,
                    account_sid: @solution['account_sid'],
                    queue_sid: @solution['queue_sid'],
                )
              end
              
              ##
              # Constructs a MemberContext
              def get(call_sid)
                MemberContext.new(
                    @version,
                    account_sid: @solution[:account_sid],
                    queue_sid: @solution[:queue_sid],
                    call_sid: call_sid,
                )
              end
              
              ##
              # Provide a user friendly representation
              def to_s
                '#<Twilio.Api.V2010.MemberList>'
              end
            end
          
            class MemberPage < Page
              def initialize(version, response, account_sid: nil, queue_sid: nil)
                super(version, response)
                
                # Path Solution
                @solution = {
                    'account_sid' => account_sid,
                    'queue_sid' => queue_sid,
                }
              end
              
              def get_instance(payload)
                return MemberInstance.new(
                    @version,
                    payload,
                    account_sid: @solution['account_sid'],
                    queue_sid: @solution['queue_sid'],
                )
              end
              
              ##
              # Provide a user friendly representation
              def to_s
                '<Twilio.Api.V2010.MemberPage>'
              end
            end
          
            class MemberContext < InstanceContext
              def initialize(version, account_sid, queue_sid, call_sid)
                super(version)
                
                # Path Solution
                @solution = {
                    account_sid: account_sid,
                    queue_sid: queue_sid,
                    call_sid: call_sid,
                }
                @uri = "/Accounts/#{@solution[:account_sid]}/Queues/#{@solution[:queue_sid]}/Members/#{@solution[:call_sid]}.json"
              end
              
              ##
              # Fetch a MemberInstance
              def fetch
                params = {}
                
                payload = @version.fetch(
                    'GET',
                    @uri,
                    params,
                )
                
                return MemberInstance.new(
                    @version,
                    payload,
                    account_sid: @solution['account_sid'],
                    queue_sid: @solution['queue_sid'],
                    call_sid: @solution['call_sid'],
                )
              end
              
              ##
              # Update the MemberInstance
              def update(url: nil, method: nil)
                data = {
                    'Url' => url,
                    'Method' => method,
                }
                
                payload = @version.update(
                    'POST',
                    @uri,
                    data: data,
                )
                
                return MemberInstance.new(
                    @version,
                    payload,
                    account_sid: @solution['account_sid'],
                    queue_sid: @solution['queue_sid'],
                    call_sid: @solution['call_sid'],
                )
              end
              
              ##
              # Provide a user friendly representation
              def to_s
                context = @solution.map {|k, v| "#{k}: #{v}"}.join(',')
                "#<Twilio.Api.V2010.MemberContext #{context}>"
              end
            end
          
            class MemberInstance < InstanceResource
              def initialize(version, payload, account_sid: nil, queue_sid: nil, call_sid: nil)
                super(version)
                
                # Marshaled Properties
                @properties = {
                    'call_sid' => payload['call_sid'],
                    'date_enqueued' => Twilio.deserialize_rfc2822(payload['date_enqueued']),
                    'position' => payload['position'].to_i,
                    'uri' => payload['uri'],
                    'wait_time' => payload['wait_time'].to_i,
                }
                
                # Context
                @instance_context = nil
                @params = {
                    'account_sid' => account_sid,
                    'queue_sid' => queue_sid,
                    'call_sid' => call_sid || @properties['call_sid'],
                }
              end
              
              def context
                unless @instance_context
                  @instance_context = MemberContext.new(
                      @version,
                      @params['account_sid'],
                      @params['queue_sid'],
                      @params['call_sid'],
                  )
                end
                @instance_context
              end
              
              def call_sid
                @properties['call_sid']
              end
              
              def date_enqueued
                @properties['date_enqueued']
              end
              
              def position
                @properties['position']
              end
              
              def uri
                @properties['uri']
              end
              
              def wait_time
                @properties['wait_time']
              end
              
              ##
              # Fetch a MemberInstance
              def fetch
                @context.fetch()
              end
              
              ##
              # Update the MemberInstance
              def update(url: nil, method: nil)
                @context.update(
                    method: nil,
                )
              end
              
              ##
              # Provide a user friendly representation
              def to_s
                context = @params.map{|k, v| "#{k}: #{v}"}.join(" ")
                "<Twilio.Api.V2010.MemberInstance #{context}>"
              end
            end
          end
        end
      end
    end
  end
end