# Image App

App sencilla que integra la Api de [Imgur](https://apidocs.imgur.com/)


### Funcionalidades disponibles

* Login
  
El login está hecho mostrando un webview con la url al login de la aplicación para hacerlo más rápido. Los modos de login con Google, facebook, etc no están disponibles en este caso, debe hacerse con usuario y contraseña.

![IMG_0093](https://github.com/radostinaTachova/imageApp/assets/115720064/2dce17d1-7046-42ee-8479-a713e3cd3ed5)  
                                                                                                                   

* Galería
  
Se ven las imágenes que tiene el usuario logeado. Se puede subir una foto, tanto de la galería como sacandola de la cámara y se puede borrar una imágen ya subida.

![IMG_0092](https://github.com/radostinaTachova/imageApp/assets/115720064/4b8339d7-9f19-46e6-a14f-0fcd399774d9)


## Arquitectura

**Clean Architecture** con dos capas (datos e interfaz) para ofrecer una separación entre la lógica de presentación y la gestión de datos junto con integración de **MVVM**, facilitando el mantenimiento, la escalabilidad.
**DI** o injeccción de dependencias con los inicializadores, para hacer la app más testable, por ejemplo, en el caso de los tests de ImageViewModel se ha podido hacer un falso repositorio injectado a este viewmodel para implementar los tests.

- *Nota: Las capas de Datos y UI no están perfectas por la decisión de realizar el login con un webView, ya que es éste el que realiza realmente el login a Imgur.*

![arquitectura](https://github.com/radostinaTachova/imageApp/assets/115720064/eeeed8b3-819b-4655-82d8-f1c97aacc633)


Flujo general:
* Los repositories hacen las llamadas a la API, o en el caso del login consultan keyChain. 
* Los viewModels llaman a estos repositorios para obtener los datos que se visualizarán en las vistas de manera reactiva (Combine + ObservableObject).
* Las APIs devuelven los modelos de datos y antes de llegar a la capa UI se hace el mapeo a los modelos de la vista para tener las capas separadas.


## Implementación, decisiones, retos

* **Login**
  
    Usando el webView he aprendido el protocolo UIViewRepresentable para integrar vistas basadas en UIKit. Por otro lado, ya que la manera correcta de hacer el login en nativo sería usando la api de Imgur he tenido dudas al principio de cómo hacerlo lo mejor posible. Desde la web de imgur he cambiado la url al hacer login para así comprobar esta url en la app y que no haya dudas. Al recibir esta url se parsea el account y se guarda el accesstoken en keyChain.
He decidido no hacer el flujo de refresh token por tiempos, asi que en el momento de expiración del token habrá errores y el usuario tendrá que hacer log out y log in denuevo.
Con el webView solo funciona el login con imgur, no se puede usar Google, etc.

* **Galería y cámara**
  
    Para abrir las fotos o la camára he investigado lo siguiente:
  *  [Photo Picker](https://developer.apple.com/documentation/photokit/photospicker)
  *  [UIImagePickerController](https://developer.apple.com/documentation/uikit/uiimagepickercontroller)
  *  [PHPickerViewController](https://developer.apple.com/documentation/photokit/phpickerviewcontroller)

    He comenzado usando UIImagePickerController tanto para el caso de la libería de fotos, como de la cámara. Sin embargo abrir la galería con esta clase está deprecado desde iOS 14 y en la documentación se recomienda usar PHPicker.A pesar de esto he decidido implementar PhotoPicker si el dispositivo tiene iOs16 y en otro caso seguir con el método deprecado. He tomado esta decisión para poder probarlo en mi dispositivo físico que no tiene iOS 16 y al mismo tiempo implementar el método más actual con SwiftUI.

  
* **Tests y DI**
  
    He implementado un par de tests sencillos de las extensiones y una clase para testar el viewmodel de las imágenes. En este último caso he creado un repositorio fake que me devuelve el camido sin errores y en los tests he usado este repositorio para crear el viewModel. Para facilitar estos tests he usado injeccción de dependecias y cada repositorio tiene un protocolo (principio SOLID).
Había pensado en usar [Factory](https://github.com/hmlongco/Factory) para la injección de dependecias, por que me gusta mucho su sencillez y lo había usado para mi app de prueba [myiOSBeerApp](https://github.com/radostinaTachova/myiOSBeerApp), pero al empezar la app sin esta librería finalmente por tiempo he decidido dejarlo así (usando los inicializadores). El DI en iOS es un tema que me sigue creando dudas, no acabo de entener cuál es la practica general en el mundo laboral. En Android es A o B y cómo los de google te recomiendan qué hacer la decisión se toma sola.

* **Mejoras**

    Como "must" para mejorar esta App, habría que reacer el login con la Api y usar el refresh. Mejorar los errores que se muestran al usuario y crear todos los tests posibles.





    
