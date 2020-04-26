Programming assessment: 

As part of the hiring process, we would like mobile developers to do a little programming assessment. 

To structure this a bit, we have the following requirements: 

 
  

Use the Dutch Rijksmuseum API, see documentation here: https://data.rijksmuseum.nl/object-metadata/api/

API - RijksData
Object metadata APIs . The object metadata APIs make the power of the award-winning Rijksmuseum website directly accessible to developers. Searching the collection through the API offers a wide range of interesting possibilities, as do the tiled images used to zoom in to close-ups of objects. The JSON-based service is so easy to use that you can create an application using the Rijksmuseum’s ...
data.rijksmuseum.nl
 (API key to use: “0fiuZFh4”)  
We would like the app to have at least two screens:  

An overview page with a list of items (preferably a collection view)  

Should have sections with headers  

Items should have text and image  

Page should be paginated  

A detail page, with more details about the item  

Loading and converting JSON to objects should be asynchronous, a loading icon / animation should be shown  

Automated tests should be present (full coverage not needed off course)  

  

Things we will be focussing on when reviewing: 

Architecture used  

Tests written  

Handling of failures (failed network calls, etc) 
