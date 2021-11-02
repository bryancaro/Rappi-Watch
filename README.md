![L1](https://user-images.githubusercontent.com/58017823/139906501-2f1772f3-6537-4ca0-9416-405107053ec2.png)

# Rappi-Watch!


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

### Video:
https://user-images.githubusercontent.com/58017823/139905660-2a943267-0c1d-4fd9-af2c-a6630381253e.mov

### Arquitecture : 
![L1](https://user-images.githubusercontent.com/58017823/139908052-8e6edb4b-59eb-4126-9293-c4c82f211fa2.png)

- Presentation Layer

SwiftUI views that contain no business logic and are a function of the state.

Side effects are triggered by the user's actions (such as a tap on a button) or view lifecycle event onAppear and are forwarded to the Interactors.

State and business logic layer (AppState + Interactors) are navitely injected into the view hierarchy with @Environment.

- Business Logic Layer

Business Logic Layer is represented by Interactors.

Interactors receive requests to perform work, such as obtaining data from an external source or making computations, but they never return data back directly.

Instead, they forward the result to the AppState or to a Binding. The latter is used when the result of work (the data) is used locally by one View and does not belong to the AppState.

Previously, this app did not use CoreData for persistence, and all loaded data were stored in the AppState.

With the persistence layer in place we have a choice - either to load the DB content onto the AppState, or serve the data from Interactors on an on-demand basis through Binding.

The first option suits best when you don't have a lot of data, for example, when you just store the last used login email in the UserDefaults. Then, the corresponding string value can just be loaded onto the AppState at launch and updated by the Interactor when the user changes the input.

The second option is better when you have massive amounts of data and introduce a fully-fledged database for storing it locally.

- Data Access Layer

Data Access Layer is represented by Repositories.

Repositories provide asynchronous API (Publisher from Combine) for making CRUD operations on the backend or a local database. They don't contain business logic, neither do they mutate the AppState. Repositories are accessible and used only by the Interactors.

### Questions
#### En qué consiste el principio de responsabilidad única? Cuál es su propósito?
Consiste en el desarrollo con clases que solo se dediquen a una tarea en especifico, con el proposito que el mantenimiento o mejora sea de facil de implementar en el codigo.

#### Qué características tiene, según su opinión, un “buen” código o código limpio
* Nombres de clases y funciones sencillos
* Componentes reutilizables 
* Organizar por medio de carpetas 
* Comentario resumido en funcionalidades complejas




### Developer: 
     - Bryan Caro Monsalve





