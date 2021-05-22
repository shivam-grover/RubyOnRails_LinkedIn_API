let getData = document.getElementById("getData");



getData.addEventListener("click", async () => {
  let [tab] = await chrome.tabs.query({ active: true, currentWindow: true });

  chrome.scripting.executeScript({
    target: { tabId: tab.id },
    function: getDataFromLinkedin,
  });
});


function getDataFromLinkedin() {
	

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

	var profileDetails = [{}];

	name = document.querySelector("div.pv-text-details__left-panel").innerText.split("\n")[0];
	profileDetails[0]['FirstName'] = name.split(" ")[0];
	profileDetails[0]['LastName'] = name.split(" ")[1];

	profileDetails[0]['Companies'] = []

	companies = document.querySelector("#experience-section ul").innerText.split("\n\nCompany Name\n\n").slice(1);

	for (i = 0; i< companies.length; i ++){

	    profileDetails[0]['Companies'].push(companies[i].split("\n")[0])
	//     console.log(companies[i].split("\n")[0])
	}

	console.log(profileDetails)

	console.save(profileDetails, profileDetails[0]["FirstName"] + " " + profileDetails[0]["LastName"] + ".json")
}

