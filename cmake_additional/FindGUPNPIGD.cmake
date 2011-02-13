include(LibFindMacros)

libfind_pkg_check_modules(GUPNPIGD_PKGCONF gupnp-igd-1.0)

if (GUPNPIGD_PKGCONF_FOUND)
  MESSAGE(STATUS "Using gupnp-igd from pkg-config")

  set(GUPNPIGD_PROCESS_INCLUDES GUPNPIGD_PKGCONF_INCLUDE_DIRS)
  set(GUPNPIGD_PROCESS_LIBS GUPNPIGD_PKGCONF_LIBRARIES)
  link_directories(${GUPNPIGD_PKGCONF_LIBRARY_DIRS})
endif()

libfind_process(GUPNPIGD)
