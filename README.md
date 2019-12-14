# UFAlert
UFAlert is a library to dela with repetitive work on Alert, Action Sheet, Popover, Banner, Toast.

## Installation
```
target 'MyApp' do
  pod 'UFAlert', '~> 1.0'
end
```

## Usage

```
private func displayAlert() {
    let actionOK = UFAlert.ActionHandler("OK", .default) {
            debugPrint("OK Pressed")
    }
    UFAlert.displayAlert(fromViewController: self, withMessage: "Message Body", Header: "Title", .alert, Handlers: [actionOK], FromView: nil, FromBounds: nil, nil, nil)
    }
    
private func displayActionSheet() {
    let actionOK = UFAlert.ActionHandler("OK", .default) {
            debugPrint("OK Pressed")
    }
    UFAlert.displayAlert(fromViewController: self, withMessage: "Message Body", Header: "Title", .actionSheet, Handlers: [actionOK], FromView: nil, FromBounds: nil, nil, nil)
}

private func displayBanner() {
    UFAlert.displayBanner(withBackgroundColor: .black, TextColor: .white, Title: "Title", ShortDescription: "Description to be displayed on the banner", Image: nil, BannerHeight: 65.0)
}

private func displayToast() {
    UFAlert.displayToastMessage(OnView: self.view, Message: "Hello world")
}
```
## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[reach2kaustavshee](https://github.com/reach2kaustavshee/UFAlert/blob/master/LICENSE)
