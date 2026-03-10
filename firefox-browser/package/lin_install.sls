# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as firefox with context %}

Install Firefox Package:
  pkg.installed:
    - pkgs:
      - {{ firefox.pkg.name }}
      {%- if grains.os_family == "RedHat" %}
      - {{ firefox.pkg_launcher.name }}
      {%- endif %}
