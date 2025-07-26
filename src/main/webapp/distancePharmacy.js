let apiKey = "";

fetch("/PharmaFinder/getApiKey")
    .then(response => response.json())
    .then(data => {
        apiKey = data.apiKey;

        document.getElementById('submitBtnLocation').addEventListener('click', function () {

            let addressFROM = document.getElementById('location').value.trim();

            let pharmLocation = document.getElementsByClassName("pharmDist");
            if (!addressFROM) {
                alert('As you have not entered a location, distance will not be displayed')
            } else {
                //Stores the user inputed-address
                localStorage.setItem('userLocation', addressFROM);

                for (let i = 0; i < pharmLocation.length; i++) {
                    let addressTO = pharmLocation[i]?.innerText || "";
                    const encodedAddressTo = encodeURIComponent(addressTO);
                    const encodedAddressFROM = encodeURIComponent(addressFROM);
                    const url = "https://maps.googleapis.com/maps/api/distancematrix/json?destinations=" + encodedAddressTo + "&origins=" + encodedAddressFROM + "&key=" + apiKey;

                    $.getJSON(url, function (data) {
                        let distanceAndTime = document.getElementsByClassName("distDisplay");
                        if (data.status === "OK" && data.rows[0].elements[0].status === "OK") {

                            let distance = "";
                            let duration = "";
                            distance = data.rows[0].elements[0].distance.text;
                            duration = data.rows[0].elements[0].duration.text;
                            distanceAndTime[i].innerHTML = "Distance:" + distance + "," + " Travel:" + duration;

                        } else {

                            distanceAndTime[i].innerHTML = "Distance:N/A , Travel:N/A";
                            alert("Incorrect location,please add street address and zipcode");

                        }
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
    });