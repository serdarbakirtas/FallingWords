# Falling Words iOS Application

## Code Style
***
+ Files are divided into following folders:
	- *protocols* -> Protocols that are used overall in the app
	- *views* -> main content, divided further views shown by application
	- *model* -> simple object classes, mostly conforms to database objects
	- *viewmodels* -> classes that represents shown data in ui, they are created from model objects 
+ Order of the files in views folder should be:
	- View Controller
	- Presenter
+ Naming of files in views folder:
	- For view controllers: *Some*ViewController
	- For presenters: *Some*Presenter
+ Naming of functions:
	- Basic functions start with verbs (i.e. loadWords())
	- Actions/Listeners usually start with 'on' (i.e. onLoadWords())
+ '// MARK:' feature should be used to divide different portions of the code. The order should be like:
	- // MARK: Properties
		+ static let
		+ let/var
		+ @ IBOutlet
	- // MARK: Actions (for views)
		+ @ IBAction
	- // MARK: Functions (other functions used in a class)
		+ Always put private keyword if func is used only in that class
	- // MARK: API Calls (for presenters)

## Dependency Management
***
+ To add a library:
	- Add "pod '_libraryname_'" to "Podfile" in the project
	- Run "pod install" from terminal
		+ You can check the difference between 'pod install' and 'pod update' at [cocoaPods guides](https://guides.cocoapods.org/using/pod-install-vs-update.html)
		+ If pod is not installed, run "sudo gem install cocoapods" first
+ To update a library:
	- Change the version number of the library in "Podfile"
	- Run "pod update {libraryname}" 
+ To check outdated libraries
 	- Run "pod outdated"

# Overview
***
+ Xcode 12.0.1
+ Supported iOS versions: 12+
+ Swift 5
+ Supported devices: iPhone - iPad (portrait and landscape orientation)

## Design and Implementation guidelines
***
+ All UI is developed in code using UIKit (no Xib/Storyboards).
+ RxSwift is used for api calls.
+ Implemented simple design and existing best practices of UI/UX and software design.

## Estimate and Desicison
***
+ Completed the full task to be completed within 6.5h time box.
	- Planning 30m
		+ Choosing best design architecture for the project.
		+ Researching best algorithm for random numbers of the data.
+ Development and Design implementation 4h.
	- Look at the "Design and Implementation guidelines" and "Code Style"
+ Unit test 2h 
 	- %78.2 Code coverage
 	- Naming of files in tests folder:
		+ For unit test: *Some*UnitTest
		+ For mock data: *Some*Mock
		
## Output Answers
***
+ Decisions made to solve certain aspects of the game
	- I decided how to generate the random number with minimum code.
		+ *NOTE: Following steps are made to have distributed equally wrong and correct answers.*
		+ All words are shuffled.
		+ 15 words are filtered from the shuffled list (1 correct, 1 wrong).
		+ The filtered word list (15 words) are shuflled again.
		+ Check the max 3 wrong answer or 15 word pair to show result.
	- I decided the best architecture for the testable code.
	- I decided to use UIKit instead of storyboard/xib files for good memory performance.
+ Decisions made because of restricted time
	- I worked on the design architecture which I have more experienced.
	- I implemented simple design.
+ Improve or add if there had been more time
 	- UI Test.
	- Use locale storage to save the scores.
