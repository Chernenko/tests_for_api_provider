require "net/http"
require "uri"

def to_log(output, result)
	File.open("./result.txt", "a") do |f|
		f.puts "Test case: Update user #{output} , #{result} "
	end
end

uri = URI('http://localhost:3000/api/users/30')
req = Net::HTTP::Put.new(uri)
req.set_form_data({
"email": "test@update.com", 
"first_name": "lana",
"last_name": "ch"
})
resp = Net::HTTP.start(uri.hostname, uri.port) do |http|
  http.request(req)
end
case resp
when Net::HTTPSuccess, Net::HTTPRedirection
  to_log('PASS',resp.code)
else
   to_log('FAIL',resp.code)
end