# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_config_clean = tplroot ~ '.config.clean' %}
{%- from tplroot ~ "/map.jinja" import mapdata as firefox with context %}

include:
  - {{ sls_config_clean }}

Uninstall Firefox Package:
  pkg.removed:
    - pkgs:
      - {{ firefox.pkg.name }}
      {%- if grains.os_family == "RedHat" %}
      - {{ firefox.pkg_launcher.name }}
      {%- endif %}
    - require:
      - sls: {{ sls_config_clean }}
