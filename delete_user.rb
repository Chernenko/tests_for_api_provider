require "net/http"
require "uri"

# POSITIVE test case (delete existing user)
def to_log(output, result)
	File.open("./result.txt", "a") do |f|
		f.puts "Test case: Delete User - #{output}, #{result} "
	end
end

uri = URI('http://localhost:3000/api/users/31')
req = Net::HTTP::Delete.new(uri)
req.set_form_data({
	"email": "new@chernenko.com", 
	"first_name": "Lana",
	"last_name": "Chernenko"
})
resp = Net::HTTP.start(uri.hostname, uri.port) do |http|
http.request(req)
end

case resp
when Net::HTTPSuccess, Net::HTTPRedirection
to_log( 'PASS','user has been successfully deleted.')
else
to_log('FAIL',resp.code)
end

# NEGATIVE test case (non-existing user)

uri = URI('http://localhost:3000/api/users/31')
req = Net::HTTP::Delete.new(uri)
req.set_form_data({
	"email": "new@chernenko.com", 
	"first_name": "Lana",
	"last_name": "Chernenko"
})
resp = Net::HTTP.start(uri.hostname, uri.port) do |http|
http.request(req)
end

case resp
when Net::HTTPSuccess, Net::HTTPRedirection
to_log( 'FAIL','Able to delete non-existing user')
else
to_log('PASS',resp.message)
end