<p align="center">
    <img src="NStack_Logo.png?raw=true" alt="NStack"/>
</p>

[![bitrise](https://app.bitrise.io/app/07acd68091c14c12/status.svg?token=xfdewD-n8sL8VIVOOTX7JA&branch=master)](https://app.bitrise.io/app/07acd68091c14c12)
[![Codecov](https://img.shields.io/codecov/c/github/nodes-ios/NStackSDK.svg)](https://codecov.io/github/nodes-ios/NStackSDK)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
![Plaform](https://img.shields.io/badge/platform-iOS%20|%20macOS%20|%20tvOS%20|%20watchOS-lightgrey.svg)
[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/nodes-ios/NStackSDK/blob/master/LICENSE)

NStackSDK is the companion software development kit to the [NStack](https://nstack.io) backend.

## What is NStack?

See the [NStack documentation](https://nstack-io.github.io/docs/docs/guides/iOS/ios.html) for more information about NStack

## 📝 Requirements

* iOS 8.0+ / tvOS 9.0+ / macOS 10.10+ / watchOS 2.0+
* Swift 3.0+

## 📦 Installation

### CocoaPods
~~~
pod 'NStackSDK', '~> 5.1.3'
~~~

### Carthage
~~~
# Swift 5
github "nstack-io/nstack-ios-sdk" ~> 4.0

# Swift 4.2-5 using Alamofire 5 - Pre-release
github "nstack-io/nstack-ios-sdk" "feature/alamofire5"

# Swift 3-4
github "nstack-io/nstack-ios-sdk" ~> 2.0

# Swift 2.3
github "nstack-io/nstack-ios-sdk" == 0.3.12

# Swift 2.2
github "nstack-io/nstack-ios-sdk" == 0.3.10
~~~
### TranslationManager

Note; to make use of the Localizable feature of Nstack you will also need the TranslationManager dependency added to your cartfile.
~~~
# Swift 5
github "nodes-ios/TranslationManager"
~~~

### Migration Swift 4.x -> Swift 5

1. Put this line in the cartfile
~~~
github "nodes-ios/NStackSDK" ~> 3.0
~~~
2. Remove all other references to Alamofire and Serpent from the Cartfile
3. run ```carthage update NStackSDK``` for your platform

### Migration to NStackSDK with Alamofire 5
1. Put this line in the Cartfile
~~~
github "nodes-ios/NStackSDK" "feature/alamofire5"
~~~
2. Remove all other references to Alamofire and Serpent from the Cartfile
3. Make sure you don't have other dependencies using Alamofire 4 or Serpent ~> 1.0. If you have, refer to the github repo for the dependency for migration pointers
3. run ```carthage update NStackSDK``` for your platform

## 💻 Usage

> **NOTE:** Don't forget to `import NStackSDK` in the top of the file.

### Getting Started

#### Plist

In your AppDelegate's `didFinishLaunching:` function start NStack by running:

~~~swift
let configuration = Configuration(plistName: "NStack", environment: .debug, translationsClass: Translations.self)
NStack.start(configuration: configuration, launchOptions: launchOptions)
~~~

The environment enum property passed should be that matching your projects environement. These enums are declared within the NStackSDK.
You should have a file called NStack.plist in your application bundle. It needs to contain a key called **`REST_API_KEY`** and a key called **`APPLICATION_ID`**.
The TranslationsClass passed should be the class generated by the NStack Translations Generator (see below).


#### Manually

> TODO: Docs

## Features

For an overview of what features are available and what they do check out the [feature overview](https://nstack-io.github.io/documentation/features.html) in the documentation.

### Localization

To use nstack for translations, you need to install the [nstack translations generator](https://github.com/nodes-ios/nstack-translations-generator). After that, all translations will be available through the tr-variable. Example: `tr.login.forgotPassword` where `login` is the section and `forgotPassword` is the key from nstack. For example:
~~~~swift
@IBOutlet weak var forgotPasswordButton: UIButton! {
    didSet {
        forgotPasswordButton.setTitle(tr.login.forgotPassword, for: .normal)
    }
}
~~~~

With the latest 4.0 release, comes other ways of assigning translations within your project...
~~~~swift
label1.text = tr.defaultSection.successKey
----
label2.localize(for: "default.successKey")
----
label3.localize(for: skt.defaultSection.successKey)
----
label4 <=> "default.successKey"
----
label5 <=> skt.defaultSection.successKey
~~~~
And with Swift 5.1 and up, you can also use the `NSLocalizable` property wrapper.
~~~~swift
@IBOutlet @NSLocalizable("default.successKey") var label6: UILabel!
----
@IBOutlet @NSLocalizable(skt.defaultSection.successKey) var label7: UILabel!
~~~~


### Responses
Responses allow you to define and update JSON files on the NStack web console and retrieve them using the NStack sdk or using a normal get request.
~~~~swift
NStack.sharedInstance.getContentResponse(id) { (data, error) in
  guard error == nil else {
    print("Error fetching response with id: \(id)")
    return
  }
            
  // Use data
}
~~~~


### Collections
Collections is a more structured version of Responses and can be used as an alternative to an simple read API.
See the [feature overview](https://nstack-io.github.io/documentation/features.html) for a more detailed explaination.

~~~~swift
let completion: (NStack.Result<Product>) -> Void = { result in
  switch result {
  case .success(let data):
    print("Fetching collection successful")
    print(data)
  case .failure(let error):
    print("Error fetching collection: \(error)")
  }
}
        
NStack.sharedInstance.fetchCollectionResponse(for: id, completion: completion)
~~~~

### Files
With files you can retrieve files defined on the NStack web console using a normal get request.
The files functionality has not been implemented in the sdk.

~~~~swift
if let url = URL(string: url) {
  URLSession.shared.downloadTask(with: url) { (localURL, urlResponse, error) in
    guard error == nil else {
        print("Error fetching file with url: \(url)")
        print(error)
        return
    }

    if let localURL = localURL {
        print("Local URL: \(localURL)")
        // Use the localURL to modify, use your newly downloaded file
    }
  }.resume()
}
~~~~

### Version control

Version control informs the user when a new version is available and what new changes are available.
You don't have to do anything to use the version control feature, just include the NStack sdk in your project.
To enable it create a new version on the NStack web console.
Checkout the [feature overview](https://nstack-io.github.io/documentation/features.html) on how to setup version control.


> **NOTE:** This feature is not yet supported on macOS and watchOS.

### Messages

Messages shows the user a custom message when the app is launched, for example warning them about a server outage.
You don't have to do anything to use the messages feature, just include the NStack sdk in your project.
To show the users a message create one on the NStack web console.
Checkout the [feature overview](https://nstack-io.github.io/documentation/features.html) on how to setup messages.

> **NOTE:** This feature is not yet supported on macOS and watchOS.

### Rate Reminder

Rate reminder shows the user Apple's build in rate reminder after the user has launched the app a certain amount of times.
You don't have to do anything to use the rate reminder feature, just include the NStack sdk in your project.
To enable the rate reminder configure it on the NStack web console.
Checkout the [feature overview](https://nstack-io.github.io/documentation/features.html) on how to setup rate reminders.

> **NOTE:** This feature is not yet supported on macOS and watchOS.

### Geography

NStack supports a list of geographical features. You can get and store list of countries, continents, langunages and timezones of the world, getting timezone for (lat, lng) coordinate and getting geographical information based on the requestee's ip address. For example:
~~~~swift
NStack.sharedInstance.timezone(lat: 12.0, lng: 55.0) { (timezone, error) in
    if let timezone = timezone {
        print("(12.0,55.0) is in timezone \(timezone.name)")
    }
}
~~~~

### Validation

NStack makes it possible to validate the syntax and domain of an email, just use:
~~~~swift
NStack.sharedInstance.validateEmail("tech@nodes.dk") { (valid, error) in
    if valid {
        //Email syntax and domain is valid
    }
}
~~~~

## 👥 Credits
Made with ❤️ at [Nodes](http://nodesagency.com).

## 📄 License
**NStackSDK** is available under the MIT license. See the [LICENSE](https://github.com/nodes-ios/NStackSDK/blob/master/LICENSE) file for more info.
