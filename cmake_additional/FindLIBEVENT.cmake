include(LibFindMacros)

# Dependencies
#libfind_package(x264 Magick)

# Use pkg-config to get hints about paths
libfind_pkg_check_modules(LIBEVENT_PKGCONF event)

# Include dir
find_path(LIBEVENT_INCLUDE_DIR
  NAMES event.h
  PATHS ${LIBEVENT_PKGCONF_INCLUDE_DIRS}
)

# Finally the library itself
find_library(LIBEVENT_LIBRARY
  NAMES event libevent
  PATHS ${LIBEVENT_PKGCONF_LIBRARY_DIRS}
)

# Set the include dir variables and the libraries and let libfind_process do the rest.
# NOTE: Singular variables for this library, plural for libraries this this lib depends on.
set(LIBEVENT_PROCESS_INCLUDES LIBEVENT_INCLUDE_DIR)
set(LIBEVENT_PROCESS_LIBS LIBEVENT_LIBRARY)
libfind_process(LIBEVENT)
