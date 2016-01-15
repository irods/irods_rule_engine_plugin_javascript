Javascript iRODS Rule Engine Plugin
===================================

Dependencies
============

- iRODS Development package (irods-dev)
- iRODS Externals packages (Clang, Boost, etc.)

Build
=====

```
$ make
```

This will download and compile v8 from Google's Chrome project.

Then it will build `libre-v8.so`.

Install
=======

```
$ make install
```

This will place the new `libre-v8.so` file into the correct location for
a standard iRODS installation (/var/lib/irods/plugins/re/) and update
the file ownership to match the iRODS server.
