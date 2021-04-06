# composer-smt

Relevant SemVer version: [2.0.0](https://semver.org/spec/v2.0.0.html)
Relevant Composer JSON Schema: [2.0.0](https://github.com/composer/composer/blob/2.0.0/res/composer-schema.json)
Relevant SMT-LIB version: [2.6-r2017-07-18](http://smtlib.cs.uiowa.edu/papers/smt-lib-reference-v2.0-r10.12.21.pdf)

General goal is an encoding of [package links](https://getcomposer.org/doc/04-schema.md#package-links)
in SMT, while respecting SemVer and [Composer's notion of versions](https://getcomposer.org/doc/articles/versions.md).

Package Links:
 - `require`
 - `conflict`
 - `replace` ?
 - `provide` ?
 - `suggest` can be ignored

## Relevant Configuration

Relevant configuration that will change preference of versions:

 - [`minimum-stability`](https://getcomposer.org/doc/04-schema.md#minimum-stability)
 - [`prefer-stable`](https://getcomposer.org/doc/04-schema.md#prefer-stable)

## TODO

 - [ ] An encoding of SemVer versions as SMT datatype.
 - [ ] An encoding of SemVer version ranges as SMT datatype.
 - [ ] An encoding of Composer's exclusion criteria (`minimum-stability`).
 - [ ] An encoding of preference (`prefer-stable`).
 - [ ] Explanation of conflicts by extraction an interpretation of UNSAT core.
 - [ ] A translation from Composer's internal package universe to SMT.
 - [ ] A translation from a model to Composer actions.

## Limitations

Does not support epochs.

## Composer Terminology

`Request`:
https://github.com/composer/composer/blob/master/src/Composer/DependencyResolver/Request.php

Packages can be marked:
 - `fixed` installed, and must remain installed
 - `locked` installed, might be uninstalled, if listed in partial update, might also be updated.
 - `fixedLocked`
 - `updateAllow`
 - `requires` (package and constraint)

### Partial Updates

Composer defines:

    /**
     * Identifies a partial update for listed packages only, all dependencies will remain at locked versions
     */
    const UPDATE_ONLY_LISTED = 0;

    /**
     * Identifies a partial update for listed packages and recursively all their dependencies, however dependencies
     * also directly required by the root composer.json and their dependencies will remain at the locked version.
     */
    const UPDATE_LISTED_WITH_TRANSITIVE_DEPS_NO_ROOT_REQUIRE = 1;

    /**
     * Identifies a partial update for listed packages and recursively all their dependencies, even dependencies
     * also directly required by the root composer.json will be updated.
     */
    const UPDATE_LISTED_WITH_TRANSITIVE_DEPS = 2;
