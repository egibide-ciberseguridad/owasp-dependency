# owasp-dependency

[OWASP Dependency-Check](https://owasp.org/www-project-dependency-check/) en un contenedor Docker.

## Funcionamiento

Lanzarlo en la carpeta raíz del proyecto a analizar:

Linux y macOS:

```shell
<ruta_al_repositorio>/owasp-dependency.sh
```

Windows:

```shell
<ruta_al_repositorio>\owasp-dependency.bat
```

El informe se genera en `~/mi_proyecto/odc-reports/dependency-check-report.html`.
