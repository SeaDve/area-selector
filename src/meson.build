areaselector_sources = [
  'main.vala',
  'selector-window.vala',
]

areaselector_deps = [
  dependency('gtk4'),
]

gnome = import('gnome')
areaselector_sources += gnome.compile_resources('area-selector-resources',
  'area-selector.gresource.xml',
  c_name: 'area_selector'
)

executable('areaselector', areaselector_sources,
  vala_args: '--target-glib=2.58',  dependencies: areaselector_deps,
  install: true,
)
