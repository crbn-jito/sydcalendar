# sydcalendar

Minimal customizable SwiftUI calendar prototype.

This repository contains a simple SwiftUI prototype for a customizable calendar app with multiple swipeable calendars, per-calendar colors and optional background photos, and a small editor to add/edit calendars.

Quick notes
- Designed as a prototype — no EventKit integration yet.
- Use Xcode 14/15+ to build and run on Simulator or device.
- Photos use PHPicker; add NSPhotoLibraryUsageDescription to Info.plist if you plan to request broader photo library access.

Files
- SydCalendarApp.swift — App entry
- ContentView.swift — Top-level navigation & TabView (swipe between calendars)
- CalendarPageView.swift — Monthly view container and header
- MonthGridView.swift / DayCell.swift — Month grid and day cells
- CalendarEditorView.swift / PhotoPicker.swift — Editor UI that allows color and photo selection
- CalendarStore.swift / Models.swift — Simple in-memory + UserDefaults persistence
- Color+Hex.swift / Extensions+Helpers.swift — Color helpers and small utilities

Running
1. Clone the repo
   git clone https://github.com/crbn-jito/sydcalendar.git
2. Open the project in Xcode (create a new SwiftUI App project and add the files, or create an Xcode project in this directory)
3. Build & Run on a Simulator

Next steps
- Add EventKit integration, CoreData/CloudKit syncing, holiday-theme mapping, and improved image storage. If you want, I can add these next.
