# The Fork Challenge

To run the project, just open it and run. It not uses any external framework.
About the networking class. Im using a simple reusable URLSession "wrapper" that I made.


## Architecture
I use VIP architecture (View -> Interactor -> Presenter). This is the first time I used this architecture, is a variation of VIPER, but the difference is that the data just have one direction, besides VIPER where the presenter works like a pivot.

### Data Models
I used 3 types of Data models:
* Models for represent data on views
* Models for parsing data (Response Objects)
* And Core Data entities

Basically the app uses a model called Restaurant, after the app fetch the data from the endpoint, the results are converted into "Restaurant" model.

## How the app works

when the view controller is loaded, the interactor is called to fetch data. After the interactor receives the response, the presenter is called, it passes an array of Restaurants to the presenter and this last one updates the view with the content.
After the view is updated the table view content is reload it.

### Favorites
What i did? well, my idea was create an array of Restaurant Strings and compare it before pass the information to a cell.
Every time a restaurant is added to favorites, core data saves it and the array of UUIDs is updated. The same if a restaurant is removed from favorites.

Maybe it is not the best solution, but it works. -.-