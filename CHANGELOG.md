## firefox-browser-formula Change Log

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/) and this project adheres to [Semantic Versioning](http://semver.org/).

### 1.0.0

**Commit Delta**: N/A

**Released**: 2026.03.11

**Summary**:

*   Initial release of capability:
    *   Manages installation of Firefox browser RPM onto Red Hat Enterprise
        Linux and related distros: requires target-host have a `dnf` repository
        configured with a channel hosting the "firefox" RPM.
    *   Manages the removal of Firefox browser RPM from Red Hat Enterprise
        Linux and related distros
    *   Manages installation of Firefox browser onto Windows-based systems.
        Installation-bundle must be in the form of a Windows EXE-installer.
    *   Manages removal of the Firefox browser from Windows-based systems:
        *   Removes binaries and related contents from standard install
            locations (`C:\Program Files\Mozilla Firefox\` and
            `C:\Program Files (x86)\Mozilla Firefox\` for 64-bit and
            32-bit target-hosts, respectively)
        *   Removes the standard, system-wide registry keys for firefox:
            *   `HKEY_LOCAL_MACHINE\SOFTWARE\Mozilla`; and
            *   `HKEY_LOCAL_MACHINE\SOFTWARE\MozillaPlugins`
