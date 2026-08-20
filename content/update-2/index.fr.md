+++
title = "Passage à Zola 0.23.4"
description = "Comment migrer un site Linkita vers Zola v0.23.4"
date = 2026-08-16
updated = 2026-08-16
[taxonomies]
authors = ["salif"]
[extra]
inline_code_fix = true
+++

Zola v0.23 a remplacé son moteur de modèles, Tera, par une nouvelle version majeure (Tera v2). Le projet Zola lui-même la qualifie de
> probablement la version la plus déstabilisante de Zola qui puisse arriver

et les modèles de Linkita ont dû être réécrits pour la suivre. Cette page vous guide dans la migration d'un site Linkita de Zola v0.22.1 vers Zola v0.23.4.

## Déplacement du dépôt

Linkita a simultanément été déplacé de Codeberg vers GitHub. Si vous utilisez toujours le dépôt Codeberg, vous devez d'abord basculer vers le dépôt GitHub. Pour les utilisateurs de sous-modules git, voici les instructions :

```sh
git submodule init
git config -f .gitmodules submodule."themes/linkita".url https://github.com/salif/linkita.git
git config -f .gitmodules submodule."themes/linkita".branch tera1
git submodule sync
git submodule update
git add .gitmodules
```

## À qui s'adresse ce guide

Ce guide s'adresse à vous si votre site utilise actuellement Linkita sur la branche `tera1` (ou sur `linkita` / `v4`) avec Zola v0.22.1 ou une version antérieure.

Si vous ne souhaitez pas encore mettre à jour Zola, vous n'avez rien à faire : la branche `tera1` continuera de fonctionner avec les anciennes versions de Zola et n'est pas supprimée.

## Étape 1 : Mettre à jour Zola vers v0.23.4

Installez Zola v0.23.4 ou une version plus récente. Vérifiez votre version installée avec :

```sh
zola --version
```

Zola v0.23 représente un grand saut. Parcourez les [notes de version de Zola v0.23.0](https://github.com/getzola/zola/blob/master/CHANGELOG.md#0230-2026-08-05) si votre site comporte des modèles personnalisés au-delà de ceux de Linkita – le reste de ce guide couvre uniquement ce qui a changé du côté de Linkita.

## Étape 2 : Basculer vers la branche `main`

La branche `main` de Linkita cible désormais Zola v0.23.0+. La branche `tera1` reste sur l'ancien moteur de modèles pour Zola v0.22.1 et les versions antérieures.

Si vous avez installé Linkita en tant que sous-module git :

```sh
git submodule set-branch --branch main themes/linkita
git submodule update --remote themes/linkita
```

## Étape 3 : Mettre à jour votre `zola.toml` / `config.toml`

Passez en revue chacun des points suivants. Aucun d'entre eux n'est strictement imposé par Zola – les anciennes clés résiduelles ne casseront pas votre compilation, mais elles cesseront silencieusement de fonctionner, il est donc utile de faire le ménage.

### Liens de menu et réseaux sociaux : `$BASE_URL` → `@base`

`$BASE_URL` dans `extra.menus`, les URL `social` de profil et `extra.footer.license_url` s'écrivent désormais `@base` :

```toml ,name=zola.toml
# Avant
[extra.menus]
menu_name = [
  { url = "$BASE_URL/blog/", name = "Archives" },
]

# Après
[extra.menus]
menu_name = [
  { url = "@base/blog/", name = "Archives" },
]
```

Le même renommage s'applique aux entrées `social` d'un profil et à `extra.footer.license_url`. Vous pouvez également utiliser les [liens internes de Zola](https://www.getzola.org/documentation/content/linking/#internal-links) (`@/...`) à la place de `@base` si vous préférez.

Il existe également un nouveau préfixe `@lang` pour les URL de menu/social qui résout un chemin dans une langue spécifique, si vous en avez besoin.

Notez que cela ne s'applique **pas** à `extra.footer.copyright` – cette chaîne utilise toujours `$BASE_URL`, `$YEAR` et `$LICENSE_URL` comme auparavant :

```toml ,name=zola.toml
[extra.footer]
copyright = "&copy; $YEAR Votre Nom &vert; [CC BY-SA 4.0]($LICENSE_URL)"
```

### Profils : Paramètres Open Graph simplifiés

La sous-table `[extra.profiles.<user>.open_graph]` a disparu. `image` et `image_alt` ont été remontées d'un niveau et renommées, `fediverse_creator` a également été remonté d'un niveau, et les champs spécifiques à Facebook (`first_name`, `last_name`, `username`, `gender`, `fb_app_id`, `fb_admins`) ainsi que la section de traduction Open Graph par langue ont été entièrement supprimés :

```toml ,name=zola.toml
# Avant
[extra.profiles.your_username.open_graph]
image = "cover.png"
image_alt = "Une description"
fediverse_creator = { handle = "me", domain = "mastodon.social" }

# Après
[extra.profiles.your_username]
# ...avatar_url, name, bio, social, etc. comme auparavant, plus :
og_image = "cover.png"
og_image_alt = "Une description"
fediverse_creator = { handle = "me", domain = "mastodon.social" }
```

Si vous comptiez sur `first_name` / `last_name` / `gender` / `fb_app_id` / `fb_admins` ou sur une surcharge par langue `open_graph.languages.<lang>.image_alt`, il n'y a pas de remplacement direct – ces champs Open Graph ne sont plus émis par le thème.

### Options de langue : `locale` supprimé, formatage des dates modifié

Le filtre `date` de Zola ne prend plus d'argument `locale`, la variable `extra.languages.<lang>.locale` (par exemple `locale = "fr_FR"`) a donc été supprimée. Le formatage de date est passé de la bibliothèque `chrono` à `jiff`, de sorte que les chaînes `date_format` sont désormais interprétées selon la [référence strftime de jiff](https://docs.rs/jiff/latest/jiff/fmt/strtime/index.html#conversion-specifications) plutôt que celle de chrono.

```toml ,name=zola.toml
# Avant
[extra.languages.fr]
locale = "fr_FR"
date_format = "%x"

# Après
[extra.languages.fr]
date_format = "%F"
num_format = "fr"
```

Effet pratique : si vous vous appuyiez sur `locale` pour afficher les noms de mois/jours traduits (via des jetons comme `%B` ou `%A`), cela ne se fait plus automatiquement. Vérifiez vos jetons `date_format` par rapport à la documentation de jiff – vous pouvez choisir de passer à un format exclusivement numérique, ou accepter que les noms de mois/jours s'affichent selon ce que jiff produit par défaut pour ce jeton. `num_format` (pour le formatage des nombres, sans rapport avec les dates) est inchangé et reste défini par langue.

### `disable_javascript` supprimé

La variable de configuration `extra.disable_javascript`, qui permettait de supprimer le JS du thème et de le réimplémenter soi-même via des injections (injects), a été supprimée.

### Liens de documentation

Si vous liez vers la documentation de Linkita, notez que la démonstration des shortcodes a été déplacée de `/shortcodes/` vers `/components/` (par exemple, la fonctionnalité projets est maintenant documentée sur `https://salif.github.io/linkita/components/#projects`).

La documentation de l'image de couverture a été clarifiée pour indiquer qu'`extra.cover.image` accepte soit un nom de fichier d'actif de page, soit un chemin compatible avec `get_url` – cela fonctionnait déjà auparavant, mais n'était pas explicité.

## Étape 4 : Mettre à jour votre contenu – les shortcodes sont désormais des composants

C'est le changement le plus susceptible d'affecter vos articles existants.

Zola v0.23 a complètement supprimé les shortcodes. Il n'y a plus de répertoire `templates/shortcodes/`, et l'ancienne façon d'appeler un shortcode comme une fonction dans le contenu Markdown (avec ou sans corps) a disparu – les deux formes échouent désormais à la compilation avec une erreur "unknown function" / "unknown tag". À la place, vos fichiers `.md` sont traités directement avec Tera, tout comme les modèles `.html`, et vous appelez les **composants** intégrés de Linkita à l'aide de la nouvelle syntaxe d'appel de Tera v2.

Un composant avec corps s'appelle ainsi – notez que le symbole pourcentage et l'accolade englobent les balises en chevrons, et non des doubles accolades :

```markdown
{% <component_name arg="value"> %}
contenu du corps
{% </component_name> %}
```

Un composant sans corps (auto-fermant) utilise des doubles accolades :

```markdown
{{<component_name arg="value" />}}
```

### Blocs d'avertissement (Admonition)

```markdown
# Avant
{% admonition(type="note", title="Une note") %}
Ceci est le corps d'une **note**.
{% end %}

# Après
{% <admonition type="note" title="Une note"> %}
Ceci est le corps d'une **note**.
{% </admonition> %}
```

### Galerie (Gallery)

Galerie nécessite désormais que `page` et `config` soient passés explicitement (les composants Tera v2 n'ont pas d'accès implicite à page/config comme les anciens shortcodes – vous les transmettez par nom, et comme les noms de variables correspondent déjà aux noms de paramètres, vous pouvez simplement écrire `page config`) :

```markdown
# Avant
{{ gallery() }}

# Après
{{<gallery page config alt="" />}}
```

### Mermaid

````markdown
# Avant
{% mermaid() %}
```mermaid
graph TD;
A-->B;
```
{% end %}

# Après
{% <mermaid> -%}
```mermaid
graph TD;
A-->B;
```
{%- </mermaid> %}
````

Utilisez les tirets de suppression d'espaces indiqués ci-dessus (juste après l'accolade-pourcentage ouvrante et juste avant la fermante) – sans eux, la ligne vide initiale précédant le bloc de code n'est pas supprimée et le diagramme s'affiche en laissant visibles les délimiteurs ` ```mermaid ` au lieu d'être nettoyé par le composant.

### Projets (Projects)

Projets nécessite également désormais que `page` et `config` soient transmis explicitement :

```markdown
# Avant
{{ projects(path="data.toml", format="toml") }}

# Après
{{<projects path="data.toml" format="toml" page config />}}
```

### Si vous écrivez sur la syntaxe Tera dans vos articles

Puisque les fichiers `.md` sont désormais traités par Tera avant l'analyse du Markdown, les balises littérales de Tera à l'intérieur d'un bloc de code – comme dans les exemples ci-dessus – seront réellement exécutées au lieu d'être affichées, même à l'intérieur de blocs de code délimités par des accents graves triples. Enveloppez tout exemple de ce type dans un bloc `raw` pour l'afficher textuellement.

```markdown
{% raw %}
...
{% endraw %}
```

## Étape 5 : Fichiers de langue personnalisés

Si vous avez ajouté un fichier personnalisé `static/i18n/<lang>.json`, synchronisez vos modifications avec le fichier de langue par défaut du thème.

## Étape 6 (avancé) : Surcharges de modèles personnalisées ou injections

Ignorez cette section sauf si vous avez surchargé l'un des modèles de Linkita, ou si vous appelez directement ses macros internes depuis vos propres modèles ou injections.

Les macros de Tera v1 ont disparu dans Tera v2, remplacées par des **composants**, qui sont appelés globalement par leur nom – plus de `{% import %}` ni d'espace de noms `self::`.

Autres changements de syntaxe de Tera v2 visibles dans les modèles, au cas où vos surcharges les utiliseraient :

- `trim_start_matches(pat=...)` / `trim_end_matches(pat=...)` deviennent `trim_start(pat=...)` / `trim_end(pat=...)`.
- `linebreaksbr` devient `newlines_to_br`.
- `default(value=x)` nécessite l'ajout de `boolean=true` (`default(value=x, boolean=true)`) pour traiter les chaînes vides/`false` comme « utiliser la valeur par défaut » – sans cela, seule une valeur réellement non définie/null déclenche la valeur par défaut.
- Le chaînage optionnel (`?.` / `?[...]`) est disponible et utilisé partout pour lire en toute sécurité des valeurs de configuration qui pourraient ne pas être définies.
- Le contexte global (`page`, `config`, `lang`, etc.) n'est plus implicitement disponible à l'intérieur d'un composant comme il l'était dans une macro – les composants le déclarent et le reçoivent explicitement, c'est pourquoi vous verrez des paramètres `page: map`, `config: map` à travers les nouveaux modèles.
- Les modèles personnalisés `templates/sitemap.xml` et `templates/split_sitemap_index.xml` ont été retirés du thème. Si vous aviez vous-même surchargé l'un d'eux, vérifiez si vous en avez toujours besoin.

Pour une vue d'ensemble complète de ce qui a changé dans Tera, consultez le [guide de migration de Tera v1 vers v2](https://github.com/Keats/tera/blob/master/MIGRATION.md).

## Étape 7 : Reconstruire et vérifier

```sh
zola build
```

Puis vérifiez en particulier :

- Que les éléments de menu et les icônes sociales pointent vers les bonnes URL (changement `@base`).
- Que l'image/description Open Graph de votre profil et la balise de lien de vérification Fediverse sont présentes dans le `<head>` de la page.
- Que le formatage des dates non anglaises est correct – c'est le point le plus susceptible d'avoir changé silencieusement (plus de noms de mois/jours traduits selon la locale).
- Que les encadrés d'avertissement, galeries, diagrammes Mermaid ou la page projets s'affichent correctement.

## Obtenir de l'aide

Si quelque chose ne correspond pas à ce qui est décrit ici, consultez le [README](https://github.com/salif/linkita/blob/main/README.md) et le [CHANGELOG](https://github.com/salif/linkita/blob/main/CHANGELOG.md) sur la branche `main`, ou [ouvrez une discussion](https://github.com/salif/linkita/discussions).
