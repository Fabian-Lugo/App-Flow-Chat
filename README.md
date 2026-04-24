# Flow-chat

<p align="center">
  <img src="assets/images/mockup_v2.png" alt="Flow-chat Mockup" width="800">
</p>

<p align="center">
  <b>Chat en tiempo real con Flutter: REST, sesión segura y WebSockets.</b>
</p>

---

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white" alt="Flutter">
  <img src="https://img.shields.io/badge/MongoDB-%234ea94b.svg?style=for-the-badge&logo=mongodb&logoColor=white" alt="MongoDB">
  <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" alt="Dart">
  <img src="https://img.shields.io/badge/Postman-FF6C37?style=for-the-badge&logo=postman&logoColor=white" alt="Postman">
</p>

## Rediseño visual (V2)

La identidad de **Flow-chat** apuesta por una estética moderna y un sistema de tokens para colores y tipografía.

| Nuevo logo | Concepto |
| :---: | :--- |
| <img src="assets/icons/app_icon.png" width="120"> | **Identidad dinámica**: burbuja de chat minimalista y ondas que representan el flujo de la conversación. |

---

## Capturas y flujo

Para usar tus propias imágenes, colócalas en `assets/screenshots/` o ajusta las rutas en las tablas siguientes.

<div align="center">

| Bienvenida | Login | Registro |
| :---: | :---: | :---: |
| <img src="assets/screenshots/welcome.png" width="250"> | <img src="assets/screenshots/login.png" width="250"> | <img src="assets/screenshots/register.png" width="250"> |

| Bandeja de entrada | Chat |
| :---: | :---: |
| <img src="assets/screenshots/inbox.png" width="250"> | <img src="assets/screenshots/chat.png" width="250"> |

</div>

---

## Sobre el proyecto

**Flow-chat** es un cliente móvil (Flutter) para un backend de chat (API REST + MongoDB y canal en tiempo real vía **Socket.IO**). El renderizado de la UI y la organización del código priorizan claridad y evolución por features.

### Pilares
- **Fluidez**: transiciones y listas con buen rendimiento.
- **Seguridad**: token almacenado con `flutter_secure_storage` y cabecera `x-token` en peticiones.
- **Tiempo real**: conexión WebSocket con el mismo `baseUrl` que la API, autenticada con el token.
- **Diseño**: `AppColors`, `AppTextStyle` y componentes reutilizables.

---

## Características principales

- **Mensajería**: historial por conversación (REST) y conexión en tiempo real (Socket.IO).
- **Autenticación**: registro, inicio de sesión y comprobación de sesión (refresh) contra la API.
- **Estado global**: `provider` con `AuthService`, `SocketService` y `MessagesService`.
- **Navegación**: `go_router` — pantalla de carga inicial, bienvenida, login, registro, bandeja anidada con chat y perfil (ver [ARCHITECTURE.md](ARCHITECTURE.md)).
- **Estructura por features**: `lib/features/<auth|chat>/` (presentación, widgets, servicios).

---

## Estructura del código

La app se organiza por **funcionalidad** (auth, chat) y módulos transversales (`api`, `services`, `theme`, `models`, `router`). El detalle de carpetas, flujo de datos y convenciones está en **[ARCHITECTURE.md](ARCHITECTURE.md)**.

---

## Configuración del backend

La URL base del API y del socket se define en `lib/api/api_config.dart` (implementación de `ApiConfig`). Ajusta `baseUrl` al host donde expongas tu API antes de generar un build que vaya a dispositivos o tiendas.

Endpoints relativos: ver `lib/api/api_endpoints.dart` (`/auth/signin`, `/auth/signup`, `/auth/refresh`, `/user/list`, `/messages/:userId`).

---

## Icono de la app

1. Sustituye `assets/icons/app_icon.png` por tu recurso.
2. Verifica en `pubspec.yaml` el bloque `icons_launcher` (el proyecto usa el paquete **icons_launcher**).
3. En la raíz del proyecto:

```bash
flutter pub get
dart run icons_launcher:create
```

---

## Instalación

1. **Clonar** el repositorio.
2. **Dependencias:** `flutter pub get`
3. **Ajustar** `lib/api/api_config.dart` a tu API.
4. **Ejecutar:** `flutter run`

---

<p align="center">
  Desarrollado con ❤️ por <b>Victor</b> | 2026
</p>
