.. _readme:

firefox-browser-formula
===============

|img_travis| |img_sr| |img_pc|

.. |img_travis| image:: https://travis-ci.com/saltstack-formulas/firefox-browser-formula.svg?branch=master
    :alt: Travis CI Build Status
    :scale: 100%
    :target: https://travis-ci.com/saltstack-formulas/firefox-browser-formula
.. |img_sr| image:: https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg
    :alt: Semantic Release
    :scale: 100%
    :target: https://github.com/semantic-release/semantic-release
.. |img_pc| image:: https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white
    :alt: pre-commit
    :scale: 100%
    :target: https://github.com/pre-commit/pre-commit

A SaltStack formula designed to facilitate the installation of the Firefox browser onto select host-types. As of this writing, supported hosts types only include RPM-based Linux distributions (RHEL and clones/work-alikes) and Windows-based systems (only specifically exercised on Server 2022 with CI-testing of Server 2019 and Server 2022).

.. contents:: **Table of Contents**
    :depth: 1

General notes
-------------

See the full `SaltStack-Formulas’ Documentation <https://salt-formulas.readthedocs.io/en/latest/>`_.

This formula is intended to be used as part of a larger, `SaltStack <https://docs.saltproject.io>`_-based configuration-automation framework (such as `Watchmaker <https://watchmaker.readthedocs.io/>`_).

If you need (non-default) configuration, please refer to:

- `how to configure the formula with map.jinja <map.jinja.rst>`_
- the ``pillar.example`` file
- the `Special notes`_ section

Contributing to this repo
-------------------------

Commit messages
^^^^^^^^^^^^^^^

**Commit message formatting is significant!!**

Please see `How to contribute <CONTRIBUTING.rst>`_ for more details.

Special notes
-------------

None

Available states
----------------

.. contents::
    :local:

``firefox``
^^^^^^^^^^^

*Meta-state (This is a state that includes other states)*.

This installs the firefox package,
manages the firefox configuration file and then
starts the associated firefox service.

``firefox.package``
^^^^^^^^^^^^^^^^^^^

This state will install the firefox package only.

``firefox.config``
^^^^^^^^^^^^^^^^^^

This state will configure the firefox service and has a dependency on ``firefox.install``
via include list.

NOTE: This formula currently does nothing when this state is called.

``firefox.service``
^^^^^^^^^^^^^^^^^^^

This state *would* start the firefox service &mdash; and has a dependency on ``firefox.config`` via include list &mdash; but the Firefox browser requires no associated services be started. As such, this formula does nothing when this state is called.


``firefox.clean``
^^^^^^^^^^^^^^^^^

*Meta-state (This is a state that includes other states)*.

This state will undo everything performed in the ``firefox`` meta-state in reverse order. In this case, the meta-state only removes the Firefox package and any packages that were also installed via dependency-tracking mechanisms

``firefox.service.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^

This state stops and disables any service the formula was previously used to start/enable

``firefox.config.clean``
^^^^^^^^^^^^^^^^^^^^^^^^

This state will remove the configuration of the firefox service and has a
dependency on ``firefox.service.clean`` via include list.

``firefox.package.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^

This state will remove any firefox package(s) and dependencies previously install by this formula. This state has a depency on
``firefox.config.clean`` via include list.

``firefox.subcomponent``
^^^^^^^^^^^^^^^^^^^^^^^^

*Meta-state (This is a state that includes other states)*.

This state *would* install subcomponent configuration files before configuring and starting the Firefox service, however, the Firefox browser does not rely on any system services to function.

``firefox.subcomponent.config``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state *would* configure Firefox subcomponent(s), however, the Firefox browser does not have any subcomponents dependencies. This state has a dependency on ``firefox.config`` via include list.

``firefox.subcomponent.config.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state will remove the configuration of any Firefox subcomponents previously installed via this formula and reload the Firefox service by a dependency on ``firefox.service.running`` via include list and ``watch_in``
requisite.

