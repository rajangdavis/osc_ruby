require 'osc_ruby/client'
require 'osc_ruby/query_module'
require 'json'
require 'uri'

module OSCRuby
	
	class ServiceProduct

		include QueryModule
		
		attr_reader :id, :lookupName, :createdTime, :updatedTime, :name
		
		attr_accessor :names, :parent, :displayOrder, :adminVisibleInterfaces, :endUserVisibleInterfaces

	    def initialize(attributes = nil)

	    	if attributes.nil?

				@names = []

				@parent = {}

				@displayOrder = 1

				@adminVisibleInterfaces = []

				@endUserVisibleInterfaces = []

			else

				@id = attributes["id"]
		      
				@lookupName = attributes["lookupName"]
		      
				@createdTime = attributes["createdTime"]
		      
				@updatedTime = attributes["updatedTime"]
		      
				@displayOrder = attributes["displayOrder"]
		      
				@name = attributes["name"]
		      
				@parent = attributes["parent"]

			end

	    end

	    def self.find(client,id = nil)

	    	check_client(client)

	    	if id.nil? == true
	    		raise ArgumentError, 'ID cannot be nil'
	    	elsif id.class != Fixnum
	    		raise ArgumentError, 'ID must be an integer'
	    	end
	    		
	    	resource = URI.escape("queryResults/?query=select * from serviceproducts where id = #{id}")

	    	service_product_json = QueryModule::find(client,resource)

	    	service_product_json_final = JSON.parse(service_product_json)

	      	new_from_fetch(service_product_json_final[0])

	    end

	    # def self.all(client)
	    	
	    # 	resource = URI.escape("queryResults/?query=select * from serviceproducts")

	    # 	service_product_json = QueryModule::find(client,resource)

	    # 	service_product_json_final = JSON.parse(service_product_json)

	    # 	service_product_json_final.map { |attributes| new_from_fetch(attributes) }

	    # end

	  #   def create(client)

	  #   	new_product = self

	  #   	empty_arr = []

	  #   	json_content = {}

			# new_product.instance_variables.each {|var| json_content[var.to_s.delete("@")] = new_product.instance_variable_get(var)}

			# empty_arr[0] = json_content

			# puts JSON.pretty_generate(empty_arr)

	  #   	resource = URI.escape("/serviceProducts")

	  #   	service_product_json = QueryModule::create(client,resource,empty_arr[0])

	  #   end

		def self.new_from_fetch(attributes)

	    	check_attributes(attributes)

	    	OSCRuby::ServiceProduct.new(attributes)

		end

		def self.check_attributes(attributes)

			if attributes.class != Hash
				
				raise ArgumentError, "Attributes must be a hash; please use the appropriate data structure"
		
			end

		end

		def self.check_client(client)

			if client.class != OSCRuby::Client || client.nil?
				raise ArgumentError, "Client must have some configuration set; please create an instance of OSCRuby::Client with configuration settings"
			end

		end

	end

end