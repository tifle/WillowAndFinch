# WillowAndFinch
Willow and Finch is a prototype IOS application that models a book selling application like Barnes and Noble.

## Text
The "Yellow Wallpaper" is the only text that we have in our system right now due to copyright and API issues. For future plans, we would like to build a .JSON file with more than one text. Due to the limited timing and ensuring that the project is as complete, we are opting for one text. Any other text will be notified that the text is unavailable.

## Assistance from Resources
* Save for Later button: https://developer.apple.com/documentation/swiftui/alert
* Setting a font and theme: https://developer.apple.com/fonts/
* Async Image: https://developer.apple.com/documentation/swiftui/asyncimage
* Text to Speech API: https://medium.com/@legin098/text-to-speech-with-swiftui-modularizing-voice-synthesis-in-swift-79410d6339ae AND https://www.hackingwithswift.com/quick-start/swiftui/how-to-read-text-from-a-textfield
* Applying ML from Python to Swift: https://medium.com/@dari.tamim028/from-python-to-swift-a-beginners-guide-to-training-converting-and-using-core-ml-models-in-swift-cc45aa39d872
* CustomTextEditor: https://developer.apple.com/documentation/swiftui/texteditor
* Book.csv: https://www.kaggle.com/code/abdallahwagih/books-recommendation-system/input
* Machine Learning: ttps://medium.com/@sudipakoner492/building-a-book-recommendation-system-using-machine-learning-popularity-and-collaborative-a472aac26a79
* Info.plist: https://www.youtube.com/watch?v=uDX6gsRtM14&ab_channel=CoffeeProgrammer

## Prompts from GenAI Models
* Assistance with Lazy Grid: i want there to be rows of books. so if there's room, i want there to be X books per row. rn it's one book per row, but there's room for 2 (context is the current layout of the search view, which was one book per row)
* Assistance with Recommended Books showing in Home page: I have this code written in Swift for Xcode. The part i'm concerned about is the Async Image section. Whenever the if statement is true, the Async Image only shows the default cover image. However, if I modify the size of the image while it is running on the preview, the correct cover images will populate. What is causing this issue and how can I fix it?
* The remaining chats didn't have direct prompts as we would enter errors that we encountered
