require 'net/http'
require 'uri'

url = 'http://localhost:3000/profiles'
uri = URI.parse(url)

params = {'firstname' => 'Rupali', 'lastname' => 'Grover', 'company' => 'IIIT'}

Net::HTTP.post_form(uri, params)
