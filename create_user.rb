require "net/http"
require "uri"
require 'time'

t = Time.now.to_i
uniq_email = "lana#{t}@gmail.com"

def to_log(output, result)
	File.open("./result.txt", "a") do |f|
		f.puts "Test case: Create new User #{output} , #{result} "
	end
end

 # POSITIVE test case (valid uniq data)

uri = URI('http://localhost:3000/api/users')
req = Net::HTTP::Post.new(uri)
req.set_form_data({
"email": "#{uniq_email}", 
"first_name": "lana",
"last_name": "ch"
})

resp = Net::HTTP.start(uri.hostname, uri.port) do |http|
  http.request(req)
end
case resp
when Net::HTTPSuccess, Net::HTTPRedirection
  to_log('PASS',resp.message)
else
   to_log('FAIL',resp.code)
end

 # NEGATIVE test case (validates_uniqueness_of :email)

uri = URI('http://localhost:3000/api/users')
req = Net::HTTP::Post.new(uri)
req.set_form_data({
"email": "#{uniq_email}", 
"first_name": "lana",
"last_name": "ch"
})

resp = Net::HTTP.start(uri.hostname, uri.port) do |http|
  http.request(req)
end
case resp
when Net::HTTPSuccess, Net::HTTPRedirection
  to_log('FAIL','Able to crete user with dup email')
else
   to_log('PASS',resp.code)
end