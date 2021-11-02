# Rappi-Watch

La aplicación permite a los usuarios visualizar un catalogo de peliculas y series de tv por categorias con sus respectivos detalles.

![Swift](https://img.shields.io/badge/Swift-UI-blue.svg)

#### Características: 
     
- Escrito en Swift 5 & Xcode 13.1
- iOS 14 & SwiftUI
- Arquitectura Model View View Model (MVVM)
- Datos suministrados por la API de Punk (https://www.themoviedb.org)
- CocoaTouch librerías de terceros (Alamofire, lottie-ios, SDWebImageSwiftUI, ReachabilitySwift)

#### Requisitos: 

- iOS 14.0+
- Xcode 13

### Integración

#### CocoaPods (iOS 9+):

Puede usar CocoaPods para agregarlos a tu Podfile e instalar las librerías :

```swift
platform :ios, '14.0'

target 'Rappi Watch' do
  use_frameworks!

  # Pods for Rappi Watch
  pod 'Alamofire', '~> 5.4'
  pod 'SDWebImageSwiftUI'
  pod 'lottie-ios'
  pod 'ReachabilitySwift'

end
```
Tenga en cuenta que esto requiere la versión 36 de CocoaPods y que su destino de implementación de iOS sea al menos 9.0

### Developer: 
     
- Bryan Caro Monsalve
