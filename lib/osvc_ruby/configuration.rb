module OSvCRuby

	class Configuration
		# A holder class that holds the configuration information for the OSvCRuby::Client block
	
	    attr_accessor :interface,:username,:password,:no_ssl_verify,:version,:suppress_rules,:demo_site, :session, :oauth, :access_token

	    def initialize
	    	@no_ssl_verify = false
	    	@version = 'v1.3'
	    	@suppress_rules = false
	    	@demo_site = false
	    end
	end
end