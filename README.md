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
```
