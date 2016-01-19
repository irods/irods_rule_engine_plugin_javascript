Javascript iRODS Rule Engine Plugin
===================================

Dependencies
============

- iRODS 4.2 or later
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

To activate the plugin, a stanza must be included in `/etc/irods/server_config.json`:

```
        {
            "instance_name": "re-v8-instance",
            "plugin_name": "re-v8"
        },
```

Note that the ordering of the rule engine stanzas matters; the first rule engine
plugin takes precedence.

The instance name can be changed; the namespace exists to allow for multiple
identical rule engine plugins to be installed concurrently (this conflicts with
the single rulebase limitation mentioned below).

Limitation
==========

Currently, this plugin only looks for a rulebase named `core.js`.

Examples
========

Included are two files, `core.js` and `custom.re`.  Together, they demonstrate how
to call across the rule engine plugins (and across languages).

`acPostProcForPut` in `core.js` overloads the out-of-the-box iRODS policy enforcement
point of the same name and writes to the standard iRODS log file.  Then it calls
`irodsFunc1` in `custom.re` which calls back to `jsFunc1` in `core.js` which
demonstrates some basic error handling after calling a function which has not
been defined (`doesnotexist()`) in any rule base.
