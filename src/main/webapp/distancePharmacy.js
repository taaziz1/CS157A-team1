function initMap() {

    document.getElementById('submitBtnLocation').addEventListener('click', function () {
        let distanceAndTime = document.getElementsByClassName("distDisplay");;
        let addressFROM = document.getElementById('location').value.trim();
        let isMedicationSearch = (window.location.pathname === "/PharmaFinder/search.jsp" && window.location.search.includes("&cat=Medication"));

        //Additional fields used to order results on medication search page
        let pharmacyCards = document.getElementsByClassName("pharmCard")
        let x = 0;

        let pharmLocation = document.getElementsByClassName("pharmDist");
        if (!addressFROM) {
            alert('As you have not entered a location, distance will not be displayed')
        } else {

            //Store the user inputted-address
            localStorage.setItem('userLocation', addressFROM);

            const service = new google.maps.DistanceMatrixService();
            for (let i = 0; i < pharmLocation.length; i++) {
                let addressTO = pharmLocation[i]?.innerText || "";
                const encodedAddressTo = encodeURIComponent(addressTO);
                const encodedAddressFROM = encodeURIComponent(addressFROM);

                const request = {
                    origins: [addressFROM],
                    destinations: [addressTO],
                    travelMode: google.maps.TravelMode.DRIVING,
                    unitSystem: google.maps.UnitSystem.METRIC,
                };

                //API Call for distance
                service.getDistanceMatrix(request).then((response) => {

                    const ans = response.rows[0].elements[0];
                    if (ans.status === "OK") {

                        let distance = ans.distance.text;
                        let duration = ans.duration.text;
                        distanceAndTime[i].innerHTML = " - " + distance + " (" + duration + ")";

                        if(isMedicationSearch) {
                            let d = distance.split(" ", 2);

                            //Divide distance by 1000 if api distance is in meters, remove commas if distance in km
                            if (d[1] === "m") {
                                pharmacyCards[i].setAttribute("data-dist", "0.00" + d[0]);
                            } else {
                                pharmacyCards[i].setAttribute("data-dist", d[0].replace(/,/g, ""));
                            }
                        }


                    } else {
                        distanceAndTime[i].innerHTML = " - N/A (N/A)";
                        if(isMedicationSearch) {
                            pharmacyCards[i].setAttribute("data-dist", "" + Number.MAX_SAFE_INTEGER);
                        }
                    }

                    if(isMedicationSearch) {
                        pharmacyCards[i].setAttribute("style", "order: " + i + ";");
                        x++;
                        if(x === pharmLocation.length) {
                            sortCards();
                        }
                    }

                }).catch((error) => {
                    console.error(error);
                    distanceAndTime[i].innerHTML = " - N/A (N/A)";
                });
            }
        }
    });

    window.addEventListener('load', function () {
        let savedLocation = localStorage.getItem('userLocation');
        if (savedLocation) {
            document.getElementById('location').value = savedLocation;
            document.getElementById('submitBtnLocation').click();

        }
    });
}

function sortCards() {
    let pharmacyCards = document.getElementsByClassName("pharmCard");
    let pharmacies = [];

    //Place all elements into an array
    for(let i = 0; i < pharmacyCards.length; i++) {
        pharmacies.push(pharmacyCards[i]);
    }

    //Sort the array based on distance
    for (let j = 1; j < pharmacies.length; j++) {
        let currentPharm = pharmacies[j];
        let k;
        for (k = j - 1; k >= 0 && parseFloat(pharmacies[k].dataset.dist) >
        parseFloat(currentPharm.dataset.dist); k--) {
            pharmacies[k].style.order = (k + 1) + "";
            pharmacies[k + 1] = pharmacies[k];
        }
        currentPharm.style.order = (k + 1) + "";
        pharmacies[k + 1] = currentPharm;
    }
}