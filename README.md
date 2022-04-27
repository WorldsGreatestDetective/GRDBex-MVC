# GRDBex-MVC

GRDBex-MVC is a demo app that takes in a users full name then saves it to a SQLite database via GRDB and a remote MySQL database via a RESTful API. After taking in the users name the application displays the users name on the following view controller where the user can also see a list of all names saved to the database.

This app performs routine asynchronous network requests via swift’s async/await. The remote server is not always online; contact [WorldsGreatestDetective](https://github.com/WorldsGreatestDetective) if need be.

## Overview

Simply enter your name and tap to save it to the database

![image](https://user-images.githubusercontent.com/12144581/163452014-4239e70c-3160-4d89-8f0c-fc1eb8ae5b09.png)

The app will then save it to a SQLite database and display it in the center of the screen where there is an option to return

![image](https://user-images.githubusercontent.com/12144581/163452233-943d6b4c-1f58-4173-a721-9b119493c722.png)

Selecting "Show all people" will present a list of all people saved to the database!

![image](https://user-images.githubusercontent.com/12144581/163452666-95a643be-f740-4a96-9873-18db864dcf9d.png)
