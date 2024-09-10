# Input set code and define static params
$set = "dsk"
$uri = "https://api.scryfall.com/"
$req = "sets/"

# Build URI and make request
$requestUri = $uri + $req + $set

# Get resulting json
$result = Invoke-WebRequest -Uri $requestUri | ConvertFrom-Json

# Isolate search URI
$searchUri = $result.search_uri

# Build card data
$cardData = Invoke-WebRequest -Uri $searchUri | ConvertFrom-Json

# Extract card list
$cardList = $cardData.data

