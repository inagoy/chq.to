# Chq.to App

Chqto es una aplicación de Ruby on Rails para generar urls acortadas. Provee un sistema de gestión de usuarios para la creación, edición y visualización de estadísticas de acceso de diversos tipos de links, permitiendo crear links con límites temporales o de cantidad de acesos, o protegidos con una contraseña.

## Requisitos Técnicos

- **Ruby:** Se requiere una versión de Ruby 2.7 (o superior).
- **Ruby on Rails:** Ruby on Rails versión 7.1.2

## Gemas incorporadas (además de Rails)

- [Chartkick](https://github.com/ankane/chartkick): Utilizada para generar el gráfico de visitas
- [Groupdate](https://github.com/ankane/groupdate): Utilizado para agrupar datos por fecha 
- [Kaminari](https://github.com/kaminari/kaminari): Utilizada para la paginación de listados de links y de visitas
- [Devise](https://github.com/heartcombo/devise): Utilizada para la gestión de usuarios


## Instrucciones (comandos) para correr la aplicación
 
1. **Instalar Dependencias:**
```bash
bundle install
```
2. **Migrar la Base de Datos:**
```bash
rails db:migrate
```
3.  **(Para generar datos en la BD: )** (*)
```bash
rails db:seed 
``` 
4. **Correr el Servidor:**
```bash
rails s
```

### (*) En el archivo seeds.rb

Se crean dos usuarios con links asociados. Juan tiene todos links que son accesibles en primera instancia, Julia tiene un link temporal no accesible para mostrar el ejemplo (se agrega un segundo en al fecha de expiración para que inmediatamente sea inaccesible). Un usuario no puede tener dos links con misma URL.

#### Usuarios:

| Email                        | Username    | Password      |
| ---------------------------- | ----------- | ------------- | 
| juan@example.com             |juan_example | password123   | 
| julia@example.com            |julia_example| password123   |

#### Links:
|Url                           | Type            | Name                      | Password  | Expiration Date         | User          | (Accesible)|    
| -----------------------------|-----------------|-------------------------- | --------- | ----------------------- | ------------- |------------|
| https://www.google.com       | Regular         | Link regular de Juan      | NULL      | NULL                    | juan_example  |     Sí     |
| https://www.github.com       | Exclusive       | Link privado de Juan      | 123456    | NULL                    | juan_example  |     Sí     |
| https://www.twitter.com      | Temporary       | NULL                      | NULL      | 2 years from now        | juan_example  |     Sí     |
| https://www.youtube.com      | Ephemeral       | Link efímero de Juancito  | NULL      | NULL                    | juan_example  |     Sí     |
| https://www.twitter.com      | Temporary       | Link temporal de Juli     | NULL      | 1 second from now       | julia_example |     No     |


#### Visitas:
* Los links del usuario juan_example tienen visitas generadas automáticamente en el seeds para graficar, menos para su link Efímero
* Los links del usuario julia_example no tienen visitas

## Algunas decisiones de Implementación
 * Se trabajó con STI para modelar los distintos tipos de Links. En la base de datos los links están todos en una misma tabla. Cada uno responde al mensaje "accessible?" de distinta manera. 
 * Los URL son únicos para un mismo usuario, es decir, en el sistema pueden existir dos URLs iguales (siempre y cuando sean de distintos usuarios). Pero nunca pueden haber dos SLUG iguales, los mismos son únicos.
 * El Slug se asigna automáticamente, es un Hash que se crea a partir de la URL y un número random, el cual se recorta a 5 caracteres. Para asegurar su unicidad se valida que no exista en la base de datos.
 * En ocasiones se debe upcastear un objeto de la subclase de Link a Link, por ejemplo en la edición del mismo para poder cambiarle el tipo. (@link.becomes(Link))
* Se trabajó con los siguientes **controladores**:

    ***De Enlaces (`LinksController`)***: CRUD de Links y Visitas asociadas***

    ***De Accesos (`AccessController`)***: Manejo de accesos (permitir o no acceso, solicitud de contraseña para links privados, registro de Visita)

    (***Home (`HomeController`)***: Renderización de la página principal)