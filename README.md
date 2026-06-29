# TwoFactorAuthDemo — Autenticación de dos factores (2FA) en PowerBuilder 🔐

![PowerBuilder](https://img.shields.io/badge/PowerBuilder-2025-2D6CDF?style=flat-square)
![.NET](https://img.shields.io/badge/.NET-10-512BD4?style=flat-square&logo=dotnet&logoColor=white)
![2FA](https://img.shields.io/badge/2FA-TOTP%20%2F%20QR-00A98F?style=flat-square)
![Blog](https://img.shields.io/badge/blog-rsrsystem-FF5722?style=flat-square&logo=blogger&logoColor=white)

## 📋 ¿Qué es esto?

Un ejemplo de **autenticación de dos factores (2FA)** estilo Google Authenticator / Authy, pero
hecho en PowerBuilder. La app genera el secreto compartido, lo pinta como **código QR** y vosotros
lo escaneáis con el móvil; a partir de ahí la aplicación valida el código temporal (TOTP) que va
cambiando cada pocos segundos. Muy útil si exponéis servicios vía API o manejáis datos sensibles y
queréis un login seguro de verdad.

🚀 **Qué podéis hacer con este ejemplo:**

- Implementar 2FA en vuestra aplicación PowerBuilder.
- Integrar un login seguro tipo **Google Authenticator / Authy**.
- Generar códigos QR dentro de vuestra app.

¿Y de dónde sale el QR? Esa parte no la hace PowerBuilder solo: para **dibujar el QR del secreto**
nos apoyamos en .NET. Cargamos la librería .NET `ZxingBarcode` (que usa **ZXing.Net**) como
`dotnetobject` con el **.NET DLL Importer** de PB, lo que nos da el objeto proxy **`nvo_zxingnet`**.
Con `nvo_zxingnet.BarcodeGenerate(...)` (formato **QR_CODE**, código `12`) generamos la imagen que
luego escanea el móvil. Como siempre, los métodos devuelven `string`, así que PowerBuilder no tiene
que capturar excepciones .NET.

## 🔗 Motor .NET

La generación del QR la hace la librería .NET **`ZxingBarcode`** (clase `ZxingNet`):

- Se **despliega** ya compilada en la carpeta `DotNet\ZxingBarcode\` de este propio ejemplo, para
  que clones, compiles y funcione sin más.
- Se **consume** desde PowerBuilder como `dotnetobject` (el proxy `nvo_zxingnet`).
- El **código fuente** vive en `Blog\Net10\ZxingBarcode` (antes estaba en `Net8`) y se
  recompila/despliega con el script **`desplegar_dotnet.bat`** (hace `dotnet publish` y espeja las
  DLLs a la carpeta `DotNet` de cada ejemplo).
- Repo del proyecto .NET (Visual Studio 2022): <https://github.com/rasanfe/ZxingBarcode>

> 🔤 **Cambio de nombre (.NET 10):** la clase .NET pasó de `ZxingNet8` a `ZxingNet`, y el objeto
> PowerBuilder de `nvo_zxingnet8` a `nvo_zxingnet` (el "8" sugería .NET 8 y confundía). Recuerda
> **recompilar y volver a desplegar** la DLL de `ZxingBarcode`.

## 🛠️ Requisitos

- **PowerBuilder 2025** para abrir y compilar la solución.
- **.NET 10 Runtime** instalado en la máquina → <https://dotnet.microsoft.com/en-us/download/dotnet/10.0>
- La carpeta `DotNet\ZxingBarcode\` con las DLLs desplegadas (ya viene en el repo).
- La app **Google Authenticator** en vuestro teléfono para escanear el QR y probar el flujo:
  <https://play.google.com/store/apps/details?id=com.google.android.apps.authenticator2&hl=es>

## ▶️ Cómo probarlo

1. Clona el repo y abre `twofactorauth.pbsln` con PowerBuilder 2025.
2. Compila (Full Build) y ejecuta.
3. Genera el secreto, deja que la app pinte el **QR** y escanéalo con Google Authenticator.
4. Introduce el código temporal que muestra el móvil y comprueba que la app lo valida.

## 🙌 Créditos

El código de este ejemplo es una adaptación del **Two Factor Authentication** de **Bruce Armstrong**,
publicado en Appeon Community:
<https://community.appeon.com/codeexchange/powerbuilder/240-two-factor-authentication>

## 🔗 Repo PowerBuilder

<https://github.com/rasanfe/TwoFactorAuthDemo>

---

> ¡Nos vemos en el próximo artículo! Y recuerda: en PowerBuilder, los límites solo están en nuestra imaginación. 🚀

📨 **Blog:** <https://rsrsystem.blogspot.com/>
