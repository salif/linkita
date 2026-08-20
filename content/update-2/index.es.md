+++
title = "Cambio a Zola 0.23.3"
description = "Cómo migrar un sitio Linkita a Zola v0.23.3"
date = 2026-08-16
updated = 2026-08-16
[taxonomies]
authors = ["salif"]
[extra]
inline_code_fix = true
+++

Zola v0.23 reemplazó su motor de plantillas, Tera, por una nueva versión principal (Tera v2). El propio proyecto Zola lo califica como
> probablemente la versión con más cambios disruptivos que jamás tendrá Zola

y las plantillas de Linkita tuvieron que ser reescritas para adaptarse a ella. Esta página te guía paso a paso para migrar un sitio Linkita de Zola v0.22.1 a Zola v0.23.3.

## Cambio de repositorio

Linkita se trasladó simultáneamente de Codeberg a GitHub. Si todavía estás utilizando el repositorio de Codeberg, primero debes cambiar al repositorio de GitHub. Para los usuarios de submódulos de git, aquí están las instrucciones:

```sh
git submodule init
git config -f .gitmodules submodule."themes/linkita".url https://github.com/salif/linkita.git
git config -f .gitmodules submodule."themes/linkita".branch tera1
git submodule sync
git submodule update
git add .gitmodules
```

## Para quién es esta guía

Esta guía es para ti si tu sitio actualmente utiliza Linkita en la rama `tera1` (o en `linkita` / `v4`) con Zola v0.22.1 o anterior.

Si todavía no deseas actualizar Zola, no tienes que hacer nada: la rama `tera1` seguirá funcionando con versiones antiguas de Zola y no desaparecerá.

## Paso 1: Actualizar Zola a v0.23.3

Instala Zola v0.23.3 o más reciente. Comprueba tu versión instalada con:

```sh
zola --version
```

Zola v0.23 es un salto importante. Echa un vistazo al [registro de cambios de Zola v0.23.0](https://github.com/getzola/zola/blob/master/CHANGELOG.md#0230-2026-08-05) si tu sitio tiene plantillas personalizadas más allá de las propias de Linkita; el resto de esta guía solo cubre lo que cambió en Linkita.

## Paso 2: Cambiar a la rama `main`

La rama `main` de Linkita ahora apunta a Zola v0.23.3+. La rama `tera1` permanece en el antiguo motor de plantillas para Zola v0.22.1 y anteriores.

Si instalaste Linkita como un submódulo de git:

```sh
git submodule set-branch --branch main themes/linkita
git submodule update --remote themes/linkita
```

## Paso 3: Actualizar tu `zola.toml` / `config.toml`

Revisa cada uno de los siguientes puntos. Ninguno de ellos es impuesto estrictamente por Zola; las claves antiguas que queden no romperán la compilación, pero dejarán de funcionar silenciosamente, por lo que vale la pena limpiarlas.

### Enlaces de menú y redes sociales: `$BASE_URL` → `@base`

`$BASE_URL` en `extra.menus`, las URL `social` de perfil y `extra.footer.license_url` ahora se escriben `@base`:

```toml ,name=zola.toml
# Antes
[extra.menus]
menu_name = [
  { url = "$BASE_URL/blog/", name = "Archivo" },
]

# Después
[extra.menus]
menu_name = [
  { url = "@base/blog/", name = "Archivo" },
]
```

El mismo renombramiento se aplica a las entradas `social` de un perfil y a `extra.footer.license_url`. También puedes usar los [enlaces internos de Zola](https://www.getzola.org/documentation/content/linking/#internal-links) (`@/...`) en lugar de `@base` si lo prefieres.

También hay un nuevo prefijo `@lang` para URL de menús/redes sociales que resuelve una ruta dentro de un idioma específico, si lo necesitas.

Ten en cuenta que esto **no** se aplica a `extra.footer.copyright`: esa cadena sigue usando `$BASE_URL`, `$YEAR` y `$LICENSE_URL` como antes:

```toml ,name=zola.toml
[extra.footer]
copyright = "&copy; $YEAR Tu Nombre &vert; [CC BY-SA 4.0]($LICENSE_URL)"
```

### Perfiles: Configuración de Open Graph simplificada

La subtabla `[extra.profiles.<user>.open_graph]` ha desaparecido. `image` e `image_alt` subieron un nivel y fueron renombradas, `fediverse_creator` también subió un nivel, y los campos específicos de Facebook (`first_name`, `last_name`, `username`, `gender`, `fb_app_id`, `fb_admins`) junto con la sección de traducción de Open Graph por idioma fueron eliminados por completo:

```toml ,name=zola.toml
# Antes
[extra.profiles.your_username.open_graph]
image = "cover.png"
image_alt = "Una descripción"
fediverse_creator = { handle = "me", domain = "mastodon.social" }

# Después
[extra.profiles.your_username]
# ...avatar_url, name, bio, social, etc. como antes, más:
og_image = "cover.png"
og_image_alt = "Una descripción"
fediverse_creator = { handle = "me", domain = "mastodon.social" }
```

Si dependías de `first_name` / `last_name` / `gender` / `fb_app_id` / `fb_admins`, o de una sobrescritura por idioma `open_graph.languages.<lang>.image_alt`, no hay un reemplazo directo: el tema ya no emite esos campos de Open Graph.

### Opciones de idioma: `locale` eliminado, cambio en el formato de fecha

El filtro `date` de Zola ya no admite un argumento `locale`, por lo que la variable `extra.languages.<lang>.locale` (p. ej., `locale = "fr_FR"`) ha sido eliminada. El formato de fecha pasó del paquete `chrono` a `jiff`, por lo que las cadenas `date_format` ahora se interpretan según la [referencia strftime de jiff](https://docs.rs/jiff/latest/jiff/fmt/strtime/index.html#conversion-specifications) en lugar de la de chrono.

```toml ,name=zola.toml
# Antes
[extra.languages.fr]
locale = "fr_FR"
date_format = "%x"

# Después
[extra.languages.fr]
date_format = "%F"
num_format = "fr"
```

El efecto práctico: si dependías de `locale` para mostrar nombres de meses/días traducidos (mediante tokens como `%B` o `%A`), eso ya no ocurre automáticamente. Comprueba tus tokens de `date_format` con la documentación de jiff: es posible que desees cambiar a un formato exclusivamente numérico o aceptar que los nombres de mes/día se representen según lo que jiff genere por defecto para ese token. `num_format` (para el formato de números, no relacionado con fechas) no cambia y sigue siendo por idioma.

### `disable_javascript` eliminado

La variable de configuración `extra.disable_javascript`, que permitía suprimir el JS del tema y reimplementarlo mediante inyecciones (injects), ha sido eliminada.

### Enlaces de documentación

Si enlazas a la documentación de Linkita en algún lugar, ten en cuenta que la demostración de shortcodes se movió de `/shortcodes/` a `/components/` (p. ej., la función de proyectos ahora está documentada en `https://salif.github.io/linkita/components/#projects`).

La documentación de la imagen de portada se aclaró para indicar que `extra.cover.image` acepta tanto un nombre de archivo de los recursos de la página como una ruta compatible con `get_url`; esto ya funcionaba antes, pero no estaba explicado explícitamente.

## Paso 4: Actualizar tu contenido – los shortcodes ahora son componentes

Este es el cambio con más probabilidades de afectar a tus publicaciones existentes.

Zola v0.23 eliminó los shortcodes por completo. Ya no existe el directorio `templates/shortcodes/`, y el estilo antiguo de invocación como llamada a función en Markdown (con o sin cuerpo) ha desaparecido: ambas formas ahora fallan la compilación con un error de "unknown function" / "unknown tag". En su lugar, tus archivos `.md` son procesados directamente por Tera igual que las plantillas `.html`, y llamas a los **componentes** integrados de Linkita usando la nueva sintaxis de llamada de Tera v2.

Un componente con cuerpo se llama así (observa que el símbolo de porcentaje y la llave envuelven las etiquetas de corchetes angulares, no llaves dobles):

```markdown
{% <component_name arg="value"> %}
contenido del cuerpo
{% </component_name> %}
```

Un componente sin cuerpo (autocerrado) usa llaves dobles en su lugar:

```markdown
{{<component_name arg="value" />}}
```

### Cuadros de aviso (Admonition)

```markdown
# Antes
{% admonition(type="note", title="Una nota") %}
Este es el cuerpo de una **nota**.
{% end %}

# Después
{% <admonition type="note" title="Una nota"> %}
Este es el cuerpo de una **nota**.
{% </admonition> %}
```

### Galería (Gallery)

Galería ahora necesita que `page` y `config` se pasen explícitamente (los componentes de Tera v2 no tienen acceso implícito a page/config como los antiguos shortcodes; se pasan por nombre y, como los nombres de las variables coinciden con los de los parámetros, simplemente puedes escribir `page config`):

```markdown
# Antes
{{ gallery() }}

# Después
{{<gallery page config alt="" />}}
```

### Mermaid

````markdown
# Antes
{% mermaid() %}
```mermaid
graph TD;
A-->B;
```
{% end %}

# Después
{% <mermaid> -%}
```mermaid
graph TD;
A-->B;
```
{%- </mermaid> %}
````

Usa los guiones para recortar espacios en blanco mostrados arriba (justo después del porcentaje de apertura y justo antes del porcentaje de cierre); sin ellos, la línea en blanco inicial previa al bloque no se elimina y el diagrama se renderiza mostrando los delimitadores ` ```mermaid ` visibles en lugar de ser limpiados por el componente.

### Proyectos (Projects)

Proyectos también necesita ahora que `page` y `config` se pasen explícitamente:

```markdown
# Antes
{{ projects(path="data.toml", format="toml") }}

# Después
{{<projects path="data.toml" format="toml" page config />}}
```

### Si escribes sobre sintaxis de Tera en tus publicaciones

Dado que los archivos `.md` ahora son procesados por Tera antes de que se analice Markdown, las etiquetas literales de Tera dentro de un bloque de código —como los ejemplos anteriores— se ejecutarán realmente en lugar de mostrarse, incluso dentro de bloques de tres tildes graves. Envuelve cualquier ejemplo similar en un bloque `raw` para mostrarlo literalmente.

```markdown
{% raw %}
...
{% endraw %}
```

## Paso 5: Archivos de idioma personalizados

Si añadiste un archivo personalizado `static/i18n/<lang>.json`, sincroniza tus cambios con el archivo de idioma predeterminado del tema.

## Paso 6 (avanzado): Sobrescrituras de plantillas o inyecciones personalizadas

Omite esta sección a menos que hayas sobrescrito alguna de las plantillas de Linkita o llames a sus macros internas directamente desde tus propias plantillas o inyecciones.

Las macros de Tera v1 han desaparecido en Tera v2, reemplazadas por **componentes**, que se llaman globalmente por nombre (ya no hay `{% import %}` ni espacio de nombres `self::`).

Otros cambios de sintaxis en Tera v2 visibles en las plantillas, en caso de que tus sobrescrituras los utilicen:

- `trim_start_matches(pat=...)` / `trim_end_matches(pat=...)` ahora son `trim_start(pat=...)` / `trim_end(pat=...)`.
- `linebreaksbr` ahora es `newlines_to_br`.
- `default(value=x)` necesita añadir `boolean=true` (`default(value=x, boolean=true)`) para tratar cadenas vacías/`false` como "usar el valor por defecto"; sin ello, solo un valor verdaderamente no definido/null activa el valor predeterminado.
- El encadenamiento opcional (`?.` / `?[...]`) está disponible y se usa en todas partes para leer valores de configuración de forma segura.
- El contexto global (`page`, `config`, `lang`, etc.) ya no está disponible implícitamente dentro de un componente como lo estaba en una macro: los componentes lo declaran y reciben explícitamente, por lo que verás parámetros `page: map`, `config: map` a lo largo de las nuevas plantillas.
- Las plantillas personalizadas `templates/sitemap.xml` y `templates/split_sitemap_index.xml` fueron eliminadas del tema. Si habías sobrescrito alguna de ellas, comprueba si todavía la necesitas.

Para conocer en detalle todo lo que cambió en Tera, consulta la [guía de migración de Tera v1 a v2](https://github.com/Keats/tera/blob/master/MIGRATION.md).

## Paso 7: Reconstruir y verificar

```sh
zola build
```

Luego revisa, especialmente:

- Que los elementos del menú y los iconos sociales apunten a las URL correctas (el cambio `@base`).
- Que la imagen/descripción Open Graph de tu perfil y la etiqueta de enlace de verificación de Fediverse estén presentes en el `<head>` de la página.
- Que el formato de fechas en idiomas distintos al inglés se vea correcto: este es el aspecto más propenso a haber cambiado silenciosamente (ya no hay nombres de mes/día traducidos por locale).
- Que cualquier cuadro de aviso, galería, diagrama Mermaid o página de proyectos se renderice correctamente.

## Obtener ayuda

Si algo no coincide con lo descrito aquí, consulta el [README](https://github.com/salif/linkita/blob/main/README.md) y el [CHANGELOG](https://github.com/salif/linkita/blob/main/CHANGELOG.md) en la rama `main`, o [inicia una discusión](https://github.com/salif/linkita/discussions).
