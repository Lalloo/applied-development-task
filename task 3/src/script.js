import './style.css'

const apiKey = "0ad3df4030a233c298c8cf93b05395a7";
const apiUrl = "http://api.openweathermap.org/data/2.5/weather?q=";
const cityNameElement = document.getElementById("cityName");
const temperatureElement = document.getElementById("temperature");
const windSpeedElement = document.getElementById("windSpeed");

function getWeather(city) {
  const url = `${apiUrl}${city}&appid=${apiKey}&lang=ru`;
  const cityNameElement = document.getElementById("cityName");
  const temperatureElement = document.getElementById("temperature");
  const windSpeedElement = document.getElementById("windSpeed");
  fetch(url)
    .then((response) => response.json())
    .then((data) => {
      cityNameElement.textContent = data.name;
      temperatureElement.textContent = data.main.temp;
      windSpeedElement.textContent = data.wind.speed;
    })
    .catch((error) => {
      console.error(error);
    });
}

window.changeCity = function () {
  const city = prompt("Введите название города:");
  console.log("works?")
  if (city) {
    getWeather(city);
  }
}

getWeather("Ivanovo");
