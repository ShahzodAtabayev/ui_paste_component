import Foundation
import Flutter
import UIKit

class PasteComponentNativeViewFactory: NSObject, FlutterPlatformViewFactory {
    private var messenger: FlutterBinaryMessenger

    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }

    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        return PasteComponentNativeView(
            frame: frame,
            viewIdentifier: viewId,
            arguments: args,
            binaryMessenger: messenger)
    }

    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
}

class PasteComponentNativeView: NSObject, UIPasteConfigurationSupporting, FlutterPlatformView {
    var pasteConfiguration: UIPasteConfiguration?
    var currentMessenger: FlutterBinaryMessenger?
    var methodChannel: FlutterMethodChannel?
    
    private var _view: UIView

    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger?
    ) {
        _view = UIView()
        currentMessenger = messenger
        methodChannel = FlutterMethodChannel(name: "ui_paste_component", binaryMessenger: currentMessenger!)
        super.init()
        createNativeView(view: _view)
    }

    func view() -> UIView {
        return _view
    }
    
    func canPaste(_ itemProviders: [NSItemProvider]) -> Bool {
        true
    }
    
    func paste(itemProviders: [NSItemProvider]) {
        if let pastedText = UIPasteboard.general.string {
            methodChannel?.invokeMethod("pasted", arguments: pastedText)
        }
    }

    func createNativeView(view _view: UIView) {
        if #available(iOS 16.0, *) {
            let configuration = UIPasteControl.Configuration()
            configuration.baseBackgroundColor = UIColor(red: 246/255.0, green: 246/255.0, blue: 246/255.0, alpha: 1)
            configuration.baseForegroundColor = UIColor(white: 0, alpha: 1)
            configuration.cornerStyle = .fixed
            configuration.displayMode = .labelOnly
            
            let pasteButton = UIPasteControl(configuration: configuration)
            pasteButton.translatesAutoresizingMaskIntoConstraints = false

            _view.addSubview(pasteButton)

            pasteButton.target = self


            NSLayoutConstraint.activate([
                pasteButton.leadingAnchor.constraint(equalTo: _view.leadingAnchor),
                pasteButton.trailingAnchor.constraint(equalTo: _view.trailingAnchor),
                pasteButton.topAnchor.constraint(equalTo: _view.topAnchor),
                pasteButton.bottomAnchor.constraint(equalTo: _view.bottomAnchor),
                pasteButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 44)
            ])
        }
    }
}