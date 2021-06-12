areaselector_sources = [
  'main.vala',
  'selector-window.vala',
]

areaselector_deps = [
  dependency('glib-2.0'),
  dependency('gtk4'),
  dependency('gobject-2.0'),
]

gnome = import('gnome')
areaselector_sources += gnome.compile_resources('area-selector-resources',
  'area-selector.gresource.xml',
  c_name: 'kooha'
)

executable('areaselector', areaselector_sources,
  vala_args: '--target-glib=2.58',  dependencies: areaselector_deps,
  install: true,
)
