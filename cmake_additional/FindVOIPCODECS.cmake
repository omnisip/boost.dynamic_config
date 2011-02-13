include(LibFindMacros)

# Dependencies
#libfind_package(x264 Magick)

# Use pkg-config to get hints about paths
libfind_pkg_check_modules(VOIPCODECS_PKGCONF voipcodecs)

# Include dir
find_path(VOIPCODECS_INCLUDE_DIR
  NAMES voipcodecs.h
  PATHS ${VOIPCODECS_PKGCONF_INCLUDE_DIRS}
)

# Finally the library itself
find_library(VOIPCODECS_LIBRARY
  NAMES voipcodecs libvoipcodecs
  PATHS ${VOIPCODECS_PKGCONF_LIBRARY_DIRS}
)

# Set the include dir variables and the libraries and let libfind_process do the rest.
# NOTE: Singular variables for this library, plural for libraries this this lib depends on.
set(VOIPCODECS_PROCESS_INCLUDES VOIPCODECS_INCLUDE_DIR)
set(VOIPCODECS_PROCESS_LIBS VOIPCODECS_LIBRARY)
libfind_process(VOIPCODECS)