require 'osvc_ruby/modules/validations_module'
require 'osvc_ruby/modules/normalize_module'
require 'json'

module OSvCRuby

	class AnalyticsReportResults

		include NormalizeModule
		include ValidationsModule

		attr_accessor :lookupName,:id, :filters

	    def initialize(**args)
	    	@lookupName = args[:lookupName]
	    	@id = args[:id]
	    	@filters = []
	    end



		def run(client)

			json_data = convert_to_json(self)

	    	response = OSvCRuby::Connect.post_or_patch(client,'analyticsReportResults',json_data)

	    	check_and_parse_response(response)

		end


		private

		def convert_to_json(s)
			json_data = {}
			check_for_id_and_name(s)
			s.instance_variables.each do|iv|
				key = iv.to_s.delete("@")
				value = instance_variable_get iv
				json_data[key] = value unless value.nil?
			end
			json_data
		end

		def check_for_id_and_name(s)
			if s.lookupName.nil? && s.id.nil?
				raise ArgumentError, "AnalyticsReportResults must have an id or lookupName set"
			end
		end

		def check_and_parse_response(response)
			if response.code.to_i != 200
				puts JSON.pretty_generate(response.body)
				response.body
			else
				body = JSON.parse(response.body)
				NormalizeModule.iterate_through_rows(body)
			end
		end

	end

end