# Arquitectura del proyecto

## Resumen

**Flow-chat** es una app Flutter de chat en tiempo real. El código se organiza por **features** (`auth`, `chat`) y capas compartidas (`api`, `services`, `models`, `theme`, `router`). La UI cubre: carga y validación de sesión, bienvenida, login, registro, bandeja, conversación y perfil. El **design system** vive en `theme/` (`AppColors`, `AppTextStyle`).

---

## Stack tecnológico

| Área | Tecnología |
|------|------------|
| Framework | Flutter / Dart (SDK en `pubspec.yaml`) |
| Navegación | [go_router](https://pub.dev/packages/go_router) — `MaterialApp.router` en `lib/main.dart`, rutas en `lib/router/` |
| Estado global | [provider](https://pub.dev/packages/provider) — `ChangeNotifier` para auth, socket y mensajes |
| Red HTTP | [http](https://pub.dev/packages/http) — login, registro, refresh, listado de usuarios y mensajes |
| Almacenamiento de token | [flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage) |
| Tiempo real | [socket_io_client](https://pub.dev/packages/socket_io_client) — `SocketService` en `lib/services/socket.dart` |
| Estilos | Tokens en `lib/theme/`; fuentes vía [google_fonts](https://pub.dev/packages/google_fonts) (Inter) |

**Configuración de API:** `lib/api/api_config.dart` define `baseUrl` (misma base para HTTP y conexión Socket.IO). `lib/api/api_endpoints.dart` define paths relativos unidos a `baseUrl`.

---

## Estructura de `lib/`

```text
lib/
├── main.dart                 # runApp, MultiProvider (Auth, Socket, Messages), MaterialApp.router
├── api/
│   ├── api_config.dart      # baseUrl; implementación concreta de ApiConfig
│   └── api_endpoints.dart   # paths REST (/auth/..., /user/..., /messages)
├── services/
│   └── socket.dart          # SocketService: Socket.IO, header x-token, estado online/offline
├── router/
│   ├── app_routes.dart     # constantes de path
│   └── router.dart         # GoRouter, rutas anidadas bajo /inbox
├── features/
│   ├── auth/
│   │   ├── presentation/   # loading, welcome, login, register
│   │   ├── widgets/         # piezas solo de auth
│   │   └── services/        # auth.dart: signIn, signUp, isSignedIn (refresh), token
│   └── chat/
│       ├── presentation/    # inbox, chat, profile
│       ├── widgets/         # mensajes, conexión, avatares, etc.
│       └── services/        # messages.dart (GET historial), user.dart (GET usuarios)
├── models/                  # User, Message, DTOs de API (sign_in, user_response, message_response, …)
├── theme/                   # colores, textos, assets referenciados
├── utils/                   # helpers de UI
└── widgets/                 # inputs, botones y componentes compartidos entre features
```

**Criterios rápidos**

- **`features/<feature>/widgets/`**: widgets usados casi solo por ese feature.
- **`lib/widgets/`**: componentes reutilizados (inputs, estilos de botón, etc.).
- **Rutas:** nombres y paths en `app_routes.dart`; la tabla en `router.dart`.
- **Datos de red:** lógica en `features/.../services/` o `services/socket.dart`, no en widgets salvo orquestación mínima.

---

## Flujo de datos (alto nivel)

1. **Arranque:** ruta inicial `AppRoutes.loading`. La pantalla de carga usa `AuthService.isSignedIn()` (GET refresh con `x-token`) para decidir ir a `inbox` o a `welcome`/`login`.
2. **Sesión:** el token se guarda de forma segura; las peticiones autenticadas añaden `x-token` (vía `AuthService.getToken()`).
3. **Listados:** p. ej. `UserService.getUsers()` y `MessagesService.getMessagesByUser(userId)` contra la API REST.
4. **Socket:** `SocketService.connectSocket()` usa el mismo `baseUrl` y envía el token en cabecera para alinear con el backend.

---

## Sistema de diseño

- Preferir `AppColors` y `AppTextStyle` para consistencia.
- Donde tenga sentido, detalles por plataforma (`Platform.isIOS`, etc.) en las pantallas o widgets afectados.

---

## Fases del proyecto (referencia)

1. **Cimientos** — Estructura por features, `go_router` y tema.
2. **UI** — Pantallas principales y design system.
3. **Integración** — API REST, token seguro, listados y Socket.IO; eventos y sincronización en vivo con el backend.

---

## Documentación relacionada

- Visión de producto, capturas e instalación: [`README.md`](README.md).
