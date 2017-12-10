#  PolyKit

`PolyKit` is wrapper library for [Poly API](https://developers.google.com/poly/) with Swift.

# Required

- Swift 4
- Xcode 4
- iOS 9~
- Carthage

# Install

## with Carthage

Add `github "fromkk/PolyKit"` to **Cartfile** and execute `carthage update` command on your terminal in project directory.

Add **Carthage/Build/{Platform}/Valy.framework** to **Link Binary with Libralies** in you project.
If you doesn't use Carthage, add **New Run Script Phase** and input `/usr/local/bin/carthage copy-frameworks` in **Build Phases** tab.
Add `$(SRCROOT)/Carthage/Build/{Platform}/PolyKit.framework` to **Input Files**.


