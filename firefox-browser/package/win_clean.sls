# -*- coding: utf-8 -*-
# vim: ft=sls
{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as firefox with context %}
{%- set ffx_install_dir = 'C:/Program Files/Mozilla Firefox/' %}
{%- set reg_keys = [
    'HKEY_LOCAL_MACHINE\SOFTWARE\Mozilla',
    'HKEY_LOCAL_MACHINE\SOFTWARE\MozillaPlugins'
  ]
%}

Uninstall Firefox application:
  cmd.run:
    - name: '"{{ firefox.pkg.uninstaller }}" /S /allusers'
    - shell: powershell
    - onlyif:
      - 'test -f {{ firefox.pkg.uninstaller }}'

Nuke the Firefox install-directory contents:
  file.directory:
    - name: '{{ ffx_install_dir }}'
    - clean: True
    - onlyif:
      = cmd: 'Uninstall Firefox application'

Nuke the Firefox install-directory:
  file.absent:
    - name: '{{ ffx_install_dir }}'

{%- for reg_key in reg_keys %}
Delete {{ reg_key }} from registry:
  reg.absent:
    - name: {{ reg_key }}
    - onlyif:
      - cmd: 'Uninstall Firefox application'
{%- endfor %}
