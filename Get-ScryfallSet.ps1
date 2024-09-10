function Get-ScryfallSet {
  # Variable parameters
  param(
    [Parameter(Mandatory=$true)]
    [string[]] $Set
    )
  
  # Define static params
  $uri = "https://api.scryfall.com/"
  $req = "sets/"
  $cardList
  $paginated = $false
  
  # Build URI and make request
  $requestUri = $uri + $req + $set
  
  # Get resulting json
  $result = Invoke-WebRequest -Uri $requestUri | ConvertFrom-Json
  
  # Isolate search URI
  $searchUri = $result.search_uri

  # Build card data
  $cardData = Invoke-WebRequest -Uri $searchUri | ConvertFrom-Json

  # Extract card list
  $cardList += $cardData.data

  # Start paginated data
  while ($cardData.has_more) {
    $searchUri = $cardData.next_page
    $cardData = Invoke-WebRequest -Uri $searchUri | ConvertFrom-Json
    $cardList += $cardData.data
  }

  return $cardList
}
