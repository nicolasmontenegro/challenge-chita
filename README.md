# challenge-chita

## Resumen
Implementación de la prueba para empresa Chita, desarrollado en Ruby sobre framework Sinatra.

## Modo de uso
Se recomienda ejecutar a través de Docker Compose para asegurar la compatibilidad de la aplicación

    docker-compose up
    
Para hacer consultas a la API, se puede enviar una request GET a la dirección http://127.0.0.1:3000

    http://127.0.0.1:3000/challenge?client_dni=76329692-K&debtor_dni=773603901&document_amount=1000000&folio=75&expiration_date=2020-07-11

Se requiere el envío de todos los parámetros que se señalan en la URL

## Implementación en Google App Engine

También se puede acceder al proyecto disponibilizado en Google App Engine a través de a URL https://challenge-chita.uc.r.appspot.com

    https://challenge-chita.uc.r.appspot.com/challenge?client_dni=76329692-K&debtor_dni=773603901&document_amount=1000000&folio=75&expiration_date=2020-07-11


> Written with [StackEdit](https://stackedit.io/).
