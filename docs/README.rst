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

A SaltStack formula designed to facilitate the installation of the Firefox browser onto select host-types. As of this writing, supported hosts types only include RPM-based Linux distributions (RHEL and clones/work-alikes).

.. contents:: **Table of Contents**
   :depth: 1

General notes
-------------

See the full `SaltStack-Formulas’ Documentation <https://salt-formulas.readthedocs.io/en/latest/>`_.

This formula is intended to be used as part of a larger, SaltStack-based configuration-automation framework (such as `Watchmaker <https://watchmaker.readthedocs.io/>`_).

If you need (non-default) configuration, please refer to:

- `how to configure the formula with map.jinja <map.jinja.rst>`_
- the ``pillar.example`` file
- the `Special notes`_ section

Contributing to this repo
-------------------------

Commit messages
^^^^^^^^^^^^^^^

**Commit message formatting is significant!!**

Please see `How to contribute <https://github.com/saltstack-formulas/.github/blob/master/CONTRIBUTING.rst>`_ for more details.

pre-commit
^^^^^^^^^^

`pre-commit <https://pre-commit.com/>`_ is configured for this formula, which you may optionally use to ease the steps involved in submitting your changes.
First install  the ``pre-commit`` package manager using the appropriate `method <https://pre-commit.com/#installation>`_, then run ``bin/install-hooks`` and
now ``pre-commit`` will run automatically on each ``git commit``. ::

  $ bin/install-hooks
  pre-commit installed at .git/hooks/pre-commit
  pre-commit installed at .git/hooks/commit-msg

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

``firefox.service``
^^^^^^^^^^^^^^^^^^^

This state will start the firefox service and has a dependency on ``firefox.config``
via include list.

``firefox.clean``
^^^^^^^^^^^^^^^^^

*Meta-state (This is a state that includes other states)*.

this state will undo everything performed in the ``firefox`` meta-state in reverse order, i.e.
stops the service,
removes the configuration file and
then uninstalls the package.

``firefox.service.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^

This state will stop the firefox service and disable it at boot time.

``firefox.config.clean``
^^^^^^^^^^^^^^^^^^^^^^^^

This state will remove the configuration of the firefox service and has a
dependency on ``firefox.service.clean`` via include list.

``firefox.package.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^

This state will remove the firefox package and has a depency on
``firefox.config.clean`` via include list.

``firefox.subcomponent``
^^^^^^^^^^^^^^^^^^^^^^^^

*Meta-state (This is a state that includes other states)*.

This state installs a subcomponent configuration file before
configuring and starting the firefox service.

``firefox.subcomponent.config``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state will configure the firefox subcomponent and has a
dependency on ``firefox.config`` via include list.

``firefox.subcomponent.config.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state will remove the configuration of the firefox subcomponent
and reload the firefox service by a dependency on
``firefox.service.running`` via include list and ``watch_in``
requisite.

Testing
-------

Linux testing is done with ``kitchen-salt``.

Requirements
^^^^^^^^^^^^

* Ruby
* Docker

.. code-block:: bash

   $ gem install bundler
   $ bundle install
   $ bin/kitchen test [platform]

Where ``[platform]`` is the platform name defined in ``kitchen.yml``,
e.g. ``debian-9-2019-2-py3``.

``bin/kitchen converge``
^^^^^^^^^^^^^^^^^^^^^^^^

Creates the docker instance and runs the ``firefox`` main state, ready for testing.

``bin/kitchen verify``
^^^^^^^^^^^^^^^^^^^^^^

Runs the ``inspec`` tests on the actual instance.

``bin/kitchen destroy``
^^^^^^^^^^^^^^^^^^^^^^^

Removes the docker instance.

``bin/kitchen test``
^^^^^^^^^^^^^^^^^^^^

Runs all of the stages above in one go: i.e. ``destroy`` + ``converge`` + ``verify`` + ``destroy``.

``bin/kitchen login``
^^^^^^^^^^^^^^^^^^^^^

Gives you SSH access to the instance for manual testing.
