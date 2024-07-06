# Movie App

A SwiftUI-based application that allows users to browse for movies. The app fetches movie data from the remote "The Movie Database" (TMDb) API and displays it in an organized and user-friendly interface.

## Features

- **List Screen**:
  - Three tabs using native tabbar for displaying: Now Playing, Popular, and Upcoming movies.
  - Fetch and display a list of movies under each tab from the TMDb API.
  - Display basic movie information such as title, release date, and poster image.

- **Detail Screen**:
  - Shows comprehensive information about the selected movie.
  - Fetch additional details about the movie (e.g., overview, genres, runtime) from the TMDb API.
  - Includes a button to navigate back to the list screen.

## Requirements

- Xcode 15
- iOS SDK 15+
- Swift 5.9+

## Architecture

The app is built using the MVVM (Model-View-ViewModel) architecture pattern for presentation layer, following Domain-Driven Design principles. The codebase is organized into domain, data, and presentation layers.

- **Domain Layer**:
  - Contains domain models representing movie entities.
  - Includes use cases for fetching movie data.

- **Data Layer**:
  - Manages network requests and data retrieval from the TMDb API.

- **Presentation Layer**:
  - Uses SwiftUI for creating views.
  - Uses Combine for view model bindings and logic.

- **Presentation Layer**: XCTest for Unit testing

* Sources:
- Dependencies (DependenciesConfigurator for setting up frameworks like Firebase)
- SupportingFiles (Info.plist, GoogleService-Info etc.)
- Rosources
    - Assets (app images)
    - Localizables - we need to add here each of language that we support,
                     so our languages will be available in settings and in `Bundle.main.preferredLocalizations` 

### Folders structure ##

* Packages /Sources:
- AppConfigurations: The AppConstants enum in Swift is a convenient way to group a set of related constant values, making them easily accessible throughout the application. This enum is specifically used for storing various constants related to the TMDb API, such as URLs and HTTP headers.
- CoreInterface: Containt UI related logic and constants
- Networking: Using URLSession for a robust network layer.
- MoviesList: The MoviesList module is responsible for displaying lists of movies categorized into three tabs: Now Playing, Popular, and Upcoming. This module fetches movie data from the TMDb API and presents it in a user-friendly interface using SwiftUI.
- MovieDetails: The MovieDetails module is responsible for displaying detailed information about a selected movie. When a user selects a movie from the list, this module fetches additional details from the TMDb API and presents them in a user-friendly interface using SwiftUI.
