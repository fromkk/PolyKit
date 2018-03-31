[![Build Status](https://travis-ci.org/fromkk/PolyKit.svg?branch=master)](https://travis-ci.org/fromkk/PolyKit)

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


# Usage

## Fetch asset from Poly API.

```swift
import PolyKit

let polyApi = PolyAPI(apiKey: "Poly API Key is HERE!!!")
polyApi.asset("dYKICaHpK0c") { (result) in
    switch result {
    case .success(let asset):
        self.showPreview(with: asset)
    case .failure(let error):
        self.showFetchFailedAlert()
    }
}
```

## Fetch assets from Poly API.

```swift
import PolyKit

let query = PolyAssetsQuery(keywords: "Cat", format: Poly3DFormat.obj)
let polyApi = PolyAPI(apiKey: "Poly API Key is HERE!!!")
polyApi.assets(with: query) { (result) in
    switch result {
    case .success(let assets):
        self.dataSource.assets = assets.assets ?? []
    case .failure(_):
        self.showFetchFailedAlert()
    }
}
```

## Download `.obj` and `.mtl` from Poly API.

```swift
import PolyKit

let asset: PolyAsset = ...
// Download obj and mtl files from Poly
asset.downloadObj { (result) in
    switch result {
    case .success(let localUrl):
        let mdlAsset = MDLAsset(url: localUrl)
        mdlAsset.loadTextures()
        let node = SCNNode(mdlObject: mdlAsset.object(at: 0))
        // do something with node
    case .failure(let error):
        debugPrint(#function, "error", error)
    }
}
```
