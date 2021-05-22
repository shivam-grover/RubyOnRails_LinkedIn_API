require 'net/http'
require 'uri'
require 'json'
require 'fileutils'

# files = Dir["LinkedInData/*"]

url = 'http://localhost:3000/profiles'
uri = URI.parse(url)

data = []


while(1)
  files = Dir["LinkedInData/*.json"]
  data = Dir["LinkedInData/Done/*.json"]

#   # puts files.length
#   # puts data.length
#
#   if(files.length > data.length)
#     # puts "in if"
    for i in 0..files.length() - 1
#
      if(not data.include? "LinkedInData/Done/" + files[i].split("/")[1])
        data.append(files[i])
#         # puts files[i]
        file = File.read(files[i])
        data_hash = JSON.parse(file)
        puts data_hash[0]['FirstName']
        puts data_hash[0]['LastName']
        puts data_hash[0]['Companies'][0]
        params = {'firstname' => data_hash[0]['FirstName'], 'lastname' => data_hash[0]['LastName'], 'company' => data_hash[0]['Companies'][0]}
        Net::HTTP.post_form(uri, params)
        FileUtils.mv(files[i], "LinkedInData/Done/" + files[i].split("/")[1])
      else
        FileUtils.mv(files[i], "LinkedInData/Done/" + files[i].split("/")[1])
      end

    end
#
#   end
  sleep(0.5)
end

# files = Dir["LinkedInData/*.json"]
# for i in 0..files.length() - 1
#   puts files[i]
# end

# for i in 0..files.length() - 1
#   puts files[i]
#   file = File.read(files[i])
#   data_hash = JSON.parse(file)
#   puts data_hash[0]['FirstName']
#   puts data_hash[0]['LastName']
#   puts data_hash[0]['Companies'][0]
#   params = {'firstname' => data_hash[0]['FirstName'], 'lastname' => data_hash[0]['LastName'], 'company' => data_hash[0]['Companies'][0]}
#   Net::HTTP.post_form(uri, params)
# end



# puts files





# params = {'firstname' => data_hash[0]['FirstName'], 'lastname' => data_hash[0]['LastName'], 'company' => data_hash[0]['Companies'][0]}
