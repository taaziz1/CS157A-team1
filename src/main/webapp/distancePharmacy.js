function initMap() {

    document.getElementById('submitBtnLocation').addEventListener('click', function () {
        let distanceAndTime = document.getElementsByClassName("distDisplay");
        let pharmacyCards = document.getElementsByClassName("pharmCard");
        let addressFROM = document.getElementById('location').value.trim();
        let x = 0;

        let pharmLocation = document.getElementsByClassName("pharmDist");
        if (!addressFROM) {
            alert('As you have not entered a location, distance will not be displayed')
        } else {
            //Stores the user inputed-address
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
                service.getDistanceMatrix(request).then((response) => {


                    const ans = response.rows[0].elements[0];
                    if (ans.status === "OK") {


                        let distance = ans.distance.text;
                        let duration = ans.duration.text;
                        distanceAndTime[i].innerHTML = "Distance:" + distance + "," + " Travel:" + duration;
                        pharmacyCards[i].setAttribute("data-dist", distance.split(" ", 1)[0]);

                    } else {

                        distanceAndTime[i].innerHTML = "Distance:N/A , Travel:N/A";
                        pharmacyCards[i].setAttribute("data-dist", "" + Number.MAX_SAFE_INTEGER);
                    }
                    x++;
                    if(x === pharmLocation.length) {
                        sortCards();
                    }
                }).catch((error) => {
                    console.error(error);
                    distanceAndTime[i].innerHTML = "Distance: N/A , Travel: N/A";
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
    for (let j = 1; j < pharmacyCards.length; j++) {
        let currentPharm = pharmacyCards[j];
        let k
        for (k = j - 1; k >= 0 && parseFloat(pharmacyCards[k].dataset.dist) >
        parseFloat(currentPharm.dataset.dist); k--) {
            pharmacyCards[k].style.order = (k + 1) + "";
            pharmacyCards[k + 1] = pharmacyCards[k];
        }
        currentPharm.style.order = (k + 1) + "";
        pharmacyCards[k + 1] = currentPharm;
    }
}