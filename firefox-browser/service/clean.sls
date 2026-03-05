# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as firefox with context %}

firefox-service-clean-service-dead:
  service.dead:
    - name: {{ firefox.service.name }}
    - enable: False
