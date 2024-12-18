# Book Reviews App

## Descripción
**Book Reviews App** es una aplicación móvil desarrollada en **Flutter** con un backend basado en **Firebase**. Permite a los usuarios explorar una lista de libros, buscar por título, autor o categoría, y dejar reseñas para los libros. Además, incluye autenticación de usuarios y un pipeline de **CI/CD** configurado con **GitHub Actions** para garantizar un desarrollo continuo. El proyecto sigue la arquitectura **MVVM** (Model-View-ViewModel) para una mejor separación de responsabilidades y mantenibilidad del código.

---

## Características principales

1. **Página de inicio**
   - Muestra una lista de libros.
   - Opciones para navegar por los libros y buscar por título, autor o categoría.

2. **Detalles de libros**
   - Visualización del título, autor, categoría y un resumen.

3. **Reseñas de libros**
   - Los usuarios pueden dejar calificaciones del 1 al 5 junto con un comentario en texto.
   - Los usuarios pueden ver las reseñas de otros, ordenadas por las más recientes.

4. **Autenticación y autorización**
   - Registro de cuentas de usuario.
   - Inicio y cierre de sesión.
   - Solo los usuarios autenticados pueden dejar reseñas.

5. **Diseño receptivo y accesible**
   - Adaptación a diferentes tamaños de pantalla.
   - Accesibilidad para usuarios con discapacidades.

6. **Pipeline de CI/CD**
   - Implementación de CI/CD con **GitHub Actions** para pruebas y despliegue automatizados.
   - Despliegue en una plataforma de alojamiento.

---

## Tecnologías

- **Frontend:** Flutter (Dart)
- **Backend:** Firebase (Firestore para los datos, Authentication para la autenticación, Hosting para el despliegue web), API de Google Books
- **Arquitectura:** MVVM (Model-View-ViewModel)
- **CI/CD:** GitHub Actions
- **Plataforma de alojamiento:** Firebase Hosting

---

## Instalación y configuración

### Pre-requisitos
- Flutter SDK instalado ([Guía de instalación](https://docs.flutter.dev/get-started/install)).
- Una cuenta de Firebase con un proyecto configurado.
- Acceso a GitHub para CI/CD.

### Configuración inicial
1. Clonar el repositorio:
   ```bash
   git clone https://github.com/usuario/book-reviews-app.git
   cd book-reviews-app
   ```

2. Instalar dependencias de Flutter:
   ```bash
   flutter pub get
   ```

3. Configurar Firebase:
   - Descarga el archivo `google-services.json` (Android) o `GoogleService-Info.plist` (iOS) desde la consola de Firebase.
   - Agrégalo a las carpetas correspondientes del proyecto.

4. Ejecutar la aplicación localmente:
   ```bash
   flutter run
   ```

---

## Estructura del proyecto

```
book-reviews-app/
├── lib/
│   ├── main.dart       # Punto de entrada de la aplicación
│   ├── views/          # Pantallas principales (Inicio, Detalles, Autenticación)
│   ├── viewmodels/     # Lógica de negocio para cada pantalla (MVVM)
│   ├── models/         # Modelos de datos
│   ├── widgets/        # Componentes reutilizables
│   ├── services/       # Interacción con Firebase
│   └── utils/          # Utilidades generales
└── .github/workflows/   # Configuración de GitHub Actions
```

---

## Planificación de desarrollo

### Etapas
1. **Diseño del UI/UX** (5 horas)
   - Diseñar pantallas con Figma.
   - Crear un prototipo funcional.

2. **Configuración inicial** (2 horas)
   - Configurar Firebase y el entorno de desarrollo Flutter.

3. **Desarrollo de funcionalidades principales** (8 horas)
   - Página de inicio y búsqueda.
   - Detalles de libros.
   - Sistema de reseñas.

4. **Autenticación y autorización** (5 horas)
   - Registro, inicio y cierre de sesión.

5. **Pruebas e integración** (2 horas)
   - Pruebas unitarias e integración con Firebase.
   - Configuración y prueba del pipeline de CI/CD.

6. **Despliegue final** (1 hora)

### Total estimado: 23 horas

---

## Licencia
Este proyecto está bajo la licencia [MIT](LICENSE).

