# CryptoTrackerApplication
 
Source code for iOs application to track cryptocurrency
Group D(Cross Section)
-Chandru Kumaran(1174815)
-Vinayak Dev(1179194)
-Judin Joseph(1173254)





The Crypto App SwiftUI is a SwiftUI-based iOS application that provides live cryptocurrency data using the CoinGecko API. This app allows users to explore real-time information about various cryptocurrencies, including prices, market caps, and more.

-App Components

The app consists of the following main components:

CryptoListView: This SwiftUI view serves as the main interface for displaying a list of cryptocurrencies. It relies on the CryptoListViewModel to handle data and functionality.

CryptoListViewModel: The view model manages the underlying data and logic for the CryptoListView. It includes the storage of a list of cryptocurrencies and loads live data through the CryptoDataService.

CryptoDataService: This service is responsible for fetching cryptocurrency data from the CoinGecko API. It provides a list of cryptocurrencies to the view model.

CryptoDetailView (Sheet): When a user taps on a cryptocurrency in the list, a detailed view is presented as a sheet. This view provides additional information about the selected cryptocurrency, including live price and market data.

-How It Works

View Loading: When the app is launched, the CryptoListView is loaded. The view contains a list of cryptocurrencies, and the CryptoListViewModel is set as an environment object for the view.

List Interaction: Users can scroll through the list of cryptocurrencies and tap on a specific cryptocurrency to view detailed information. Cryptocurrency Selection: When a user taps on a cryptocurrency, it triggers the presentation of a detailed view (sheet) with live data fetched from the CoinGecko API.

CryptoListViewModel: The view model handles data and functionality for the view. It communicates with the CryptoDataService to fetch live cryptocurrency data.
