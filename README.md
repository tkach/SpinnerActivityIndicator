SpinnerActivityIndicator
===================

UIKit dynamics based activity indicator that works like a real fidget spinner.
Your users will be much more entertained when they have an option to spin a spinner 
while your app is loading data/ uncompressing database/ mining [you_name_it]coins etc. 
Easily customizable via Interface Builder.

![Demo](https://user-images.githubusercontent.com/1849482/33743411-62a7f42c-dbb5-11e7-8518-91cc0b3ec91e.gif)

Features
--
- Simple and quick integration
- Customizable via Interface Builder and from code
- Fun

Installation
--

* via Cocoapods
```ruby
use_frameworks!

platform :ios, "9.0"

target 'YourTarget' do
	pod 'SpinnerActivityIndicator'
end

```
* manual

```
Copy Pod folder from this repo to your project

```

Using and customizing
--
1. Add UIView to your xib or storyboard file, change it's class to SpinnerActivityIndicator.
2. Add constraints (Width and height define touchable area for user interaction so it should be big enough (> 100 would be great)
3. Customize color and isAnimating properties in Interface Builder
4. If you need custom Spinner image or size, set `style` property from code:

```
@IBOutlet weak var spinnerActivity: SpinnerActivityIndicator!
override func viewDidLoad() {
    super.viewDidLoad()
    spinnerActivity.style = .custom(size: mySize, image: mySpinnerImage)
}

```
