# Holdings Portfolio App

An iOS app that lets you track your stock portfolio with real-time data and offline support. Built with clean architecture and comprehensive testing.

## What it does

This app shows your stock holdings in a simple, easy-to-read format. You get a portfolio summary at the top that you can expand to see details, and below that, all your individual holdings are listed with the key information you need.

The app works offline too - if your internet cuts out, it'll show you the last data it downloaded

## Key Features

**Portfolio Overview**
- Expandable summary showing your total portfolio value
- Individual stock listings with current prices and P&L
- Color-coded gains and losses (green for profits, red for losses)

**Smart Data Handling**
- Fetches live data from the API when connected
- Automatically saves data locally for offline viewing  
- Shows loading indicators while fetching new data
- Handles network errors gracefully

**Financial Calculations**
The app calculates everything according to the standard formulas:
- Current Value = LTP × quantity
- Total Investment = Average Price × quantity  
- Total P&L = Current Value − Total Investment
- Today's P&L = (Close − LTP) × quantity

## How it's built

The app follows MVVM (Model-View-ViewModel) architecture with SOLID Principle

**The Structure:**
- **Views** handle the UI (table views, custom cells, portfolio summary)
- **ViewModels** manage the business logic and data flow
- **Models** represent the data (holdings, portfolio calculations)
- **Services** handle network requests and data caching

**Why this approach:**
- Easy to test each part independently
- Changes in one area don't break others
- Clean separation of concerns
- Mock objects make testing reliable

## Project Structure

```
├── Model/
│   ├── APIResponseModels.swift      # Codable API response models
│   ├── Holding.swift                # Core Holding model (Codable)
│   ├── Holding+Calculations.swift   # Holding calculation extensions
│   ├── PortfolioSummary.swift       # Portfolio summary model
│   └── PortfolioSummary+Calculations.swift # Portfolio calculation extensions
├── View/                            # UI components and view controllers  
├── ViewModel/                       # Business logic layer
├── Services/
│   ├── NetworkService.swift         # API communication implementation
│   ├── CacheService.swift          # Local data persistence implementation
│   ├── HoldingsService.swift       # Holdings data orchestration
│   └── NetworkError.swift          # Network error definitions
├── Protocols/
│   ├── NetworkServiceProtocol.swift # Network service contract
│   ├── CacheServiceProtocol.swift  # Cache service contract
│   ├── HoldingsServiceProtocol.swift # Holdings service contract
│   └── HoldingsViewModelProtocol.swift # ViewModel contract
├── DI/                              # Dependency injection setup
└── Tests/                           # Unit tests for all components
```

## Testing

The app has comprehensive test coverage:

**What's tested:**
- All financial calculations with real numbers
- Network requests and error handling
- Offline caching behavior
- UI state management
- Edge cases (zero values, empty data, network failures)

**Test approach:**
- Unit tests for individual components
- Integration tests for service interactions  
- Mock objects to isolate what we're testing

## UI Design

**Portfolio Summary**
- Tap to expand/collapse with smooth animation
- Shows total value, investment, and P&L at a glance
- Color-coded gains (green) and losses (red)

**Holdings List**  
- Shows symbol, quantity, current price, and P&L
- Optimized scrolling performance
- Loading indicator while fetching data

## Offline Support

The app handles network issues gracefully:
- Automatically saves data when online
- Shows cached data when offline

## Future Ideas

Here are some features that could make the app even better:

UI Testing – add automated UI tests to validate user flows.
Navigation Upgrade – move towards MVVM + Router/Coordinator for cleaner navigation.
Image Handling – integrate SDWebImage for efficient image loading and caching.
Data Persistence – support larger datasets using CoreData or Realm.
Localization – add support for multiple languages and regions.

*Built with Swift and UIKit using clean architecture principles.*
