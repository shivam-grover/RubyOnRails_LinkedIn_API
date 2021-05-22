require 'net/http'
require 'uri'
require 'json'
require 'fileutils'


#the url on our server where I will receive the database
url = 'http://localhost:3000/profiles'
uri = URI.parse(url)

#an array to keep track of the data records already uploaded
data = []

#infinite loop
while(1)

  #gets all JSON files in the LinkedInData folder. These files are those which are newly added
  files = Dir["LinkedInData/*.json"]

  #gets all JSON files in the LinkedInData/Done folder. These files are those which have already been checked and uploaded if needed
  data = Dir["LinkedInData/Done/*.json"]

  #check for all newly added files
    for i in 0..files.length() - 1

      #if they were not already uploaded only then upload them
      if(not data.include? "LinkedInData/Done/" + files[i].split("/")[1])
        data.append(files[i])

        #get the file
        file = File.read(files[i])
        #parse the json file
        data_hash = JSON.parse(file)

        #printing for debugging
        puts data_hash[0]['FirstName']
        puts data_hash[0]['LastName']
        puts data_hash[0]['Companies'][0]

        #create object to send. I only send the first company name instead of the whole list
        params = {'firstname' => data_hash[0]['FirstName'], 'lastname' => data_hash[0]['LastName'], 'company' => data_hash[0]['Companies'][0]}

        #send to server
        Net::HTTP.post_form(uri, params)

        #move the upload json file to the Done directory
        FileUtils.mv(files[i], "LinkedInData/Done/" + files[i].split("/")[1])
      else
        #if newly added file was already upload, move it to done directory. This is the equivalent of removing it.
        FileUtils.mv(files[i], "LinkedInData/Done/" + files[i].split("/")[1])
      end

    end

  #wait for half second before looping
  sleep(0.5)
end
