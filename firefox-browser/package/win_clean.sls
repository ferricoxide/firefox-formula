# -*- coding: utf-8 -*-
# vim: ft=sls
{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as firefox with context %}

Unnstall Firefox application:
  cmd.run:
    - name: '{{ firefox.pkg.uninstaller }} /S /allusers'
    - shell: powershell
    - onlyif:
      - cmd: 'test -f {{ firefox.pkg.uninstaller }}'

