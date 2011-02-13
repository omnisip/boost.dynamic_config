include(LibFindMacros)

# Dependencies
#libfind_package(x264 Magick)

# Use pkg-config to get hints about paths
libfind_pkg_check_modules(OPAL_PKGCONF opal)

# Include dir
find_path(OPAL_INCLUDE_DIR
  NAMES opal.h
  PATHS ${OPAL_PKGCONF_INCLUDE_DIRS}
)

# Finally the library itself
find_library(OPAL_LIBRARY
  NAMES opal libopal opald 
  PATHS ${OPAL_PKGCONF_LIBRARY_DIRS}
)

# Set the include dir variables and the libraries and let libfind_process do the rest.
# NOTE: Singular variables for this library, plural for libraries this this lib depends on.
set(OPAL_PROCESS_INCLUDES OPAL_INCLUDE_DIR)
set(OPAL_PROCESS_LIBS OPAL_LIBRARY)
libfind_process(OPAL)
