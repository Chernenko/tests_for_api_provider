require "net/http"
require "uri"

def to_log(output, result)
	File.open("./result.txt", "a") do |f|
		f.puts "Test case: Check Status #{output} with result: code = #{result} "
	end
end

url = 'http://localhost:3000/api/users' 
resp = Net::HTTP.get_response(URI.parse(url))
resp.code


case resp
	when Net::HTTPSuccess, Net::HTTPRedirection
    to_log( 'PASS',resp.code)
	else
		to_log('FAIL',resp.code)
end
