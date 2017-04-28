require 'forwardable'

module ChargeBee
  class ListResult 
    extend Forwardable
    include Enumerable
    
    def_delegator :@list, :each, :each
    def_delegator :@list, :length, :length
    
    attr_reader :next_offset

    def initialize(response, next_offset=nil)
      @response = response
      @list = Array.new
      # 2017-04 Not sure if .to_s is intentional. It broke a test, but hasn't changed in 
      # since 2014, so I changed the test
      @next_offset = JSON.parse(next_offset).to_s if next_offset
      initItems()
    end
    
    private
    def initItems()
      @response.each do |item|
        @list.push(Result.new(item))
      end
    end
  
  end
end
