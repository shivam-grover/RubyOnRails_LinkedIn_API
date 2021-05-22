
// button element
let getData = document.getElementById("getData");


//adding click listener and calling getDataFromLinkedIn whenever the button in the extension is clicked
getData.addEventListener("click", async () => {
  let [tab] = await chrome.tabs.query({ active: true, currentWindow: true });

  chrome.scripting.executeScript({
    target: { tabId: tab.id },
    function: getDataFromLinkedin,
  });
});


//the function responsible for the scraping
function getDataFromLinkedin() {
	
	//this function is used to save the data as a JSON file
	(function(console){

	console.save = function(data, filename){
		
	    if(!data) {
	        console.error('Console.save: No data')
	        return;
	    }

	    if(!filename) filename = 'console.json'

	    if(typeof data === "object"){
	        data = JSON.stringify(data, undefined, 4)
	    }

	    var blob = new Blob([data], {type: 'text/json'}),
	        e    = document.createEvent('MouseEvents'),
	        a    = document.createElement('a')

	    a.download = filename
	    a.href = window.URL.createObjectURL(blob)
	    a.dataset.downloadurl =  ['text/json', a.download, a.href].join(':')
	    e.initMouseEvent('click', true, false, window, 0, 0, 0, 0, 0, false, false, false, false, 0, null)
	    a.dispatchEvent(e)
	 }
	})(console)


	//empty object for the data
	var profileDetails = [{}];

	//getting the name from the html
	name = document.querySelector("div.pv-text-details__left-panel").innerText.split("\n")[0];
	
	//splitting name into the first and the second name. If there are more than two names, we will get upto the second name. Alternatively instead of name.split(" ")[1], I can also fetch the last element to get the last name
	profileDetails[0]['FirstName'] = name.split(" ")[0];
	profileDetails[0]['LastName'] = name.split(" ")[1];

	//initializing an empty array for storing the list of companies
	profileDetails[0]['Companies'] = []

	//getting the whole section in which companies are written and then extracting the text and splitting the whole list into different elements
	companies = document.querySelector("#experience-section ul").innerText.split("\n\nCompany Name\n\n").slice(1);

	for (i = 0; i< companies.length; i ++){

		//extracting only the company name from all the data
	    profileDetails[0]['Companies'].push(companies[i].split("\n")[0])
	}

	//printing the final data
	console.log(profileDetails)
	//saving the final data
	console.save(profileDetails, profileDetails[0]["FirstName"] + " " + profileDetails[0]["LastName"] + ".json")
}
