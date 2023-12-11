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
Se crean dos usuarios con links asociados, los cuales a su vez tiene visitas ya generadas (principalmente para la visualización de la información graficada en los charts)

#### Usuarios:

| Email                        | Username    | Password      |
| ---------------------------- | ----------- | ------------- | 
| juan@example.com             |juan_example | password123   | 
| julia@example.com            |julia_example| password123   |

#### Links:
|Url                           | Type            | Name              | Password  | Expiration Date | User      | Accesible? |
| -----------------------------|-----------------|------------------ | --------- | --------------- | ----------|------------|
|


## Decisiones de Implementación



### Controladores:

* **De Enlaces (`LinksController`):** CRUD de Links y Visitas asociadas
* **De Accesos (`AccessController`):** Manejo de accesos (permitir o no acceso, solicitud de contraseña para links privados, registro de Visita)
* ( **Home (`HomeController`):** Renderización de la página principal )