require 'osvc_ruby/modules/validations_module'
require 'osvc_ruby/modules/normalize_module'
require_relative '../../ext/string.rb'
require 'json'

module OSvCRuby

	class QueryResults

		include ValidationsModule, NormalizeModule

		def initialize; end

		def query(client,query)

			self.check_query(query,"query")

			@query = URI.escape("queryResults/?query=#{query}")
	    	
	    	obj_to_find = OSvCRuby::Connect.get(client,@query)

			if obj_to_find.code.to_i == 200 || obj_to_find.code.to_i == 201

				response = NormalizeModule::normalize(obj_to_find)
			else

				response = obj_to_find.body

			end

	    	JSON.parse(response) 
 			
		end

		def check_query(query,method_name = "where")

			if query.empty?
				
				raise ArgumentError, "A query must be specified when using the '#{method_name}' method"

			end

	    end
	
	end

end