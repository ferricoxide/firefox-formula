# -*- coding: utf-8 -*-
# vim: ft=sls
{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as firefox with context %}

{%- set stage_loc = 'C:/temp/firefox-setup.exe' %}

Download Firefox installer:
  file.managed:
    - name: '{{ stage_loc }}'
    - skip_verify: True
    - source: '{{ firefox.pkg.name }}'
    - makedirs: True

Install Firefox application:
  cmd.run:
    - name: '{{ stage_loc }} /S /allusers'
    - shell: powershell
    - onchanges:
      - file: 'Download Firefox installer'
