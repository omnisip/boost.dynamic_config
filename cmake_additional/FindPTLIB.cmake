include(LibFindMacros)

# Dependencies
#libfind_package(x264 Magick)

# Use pkg-config to get hints about paths
libfind_pkg_check_modules(PTLIB_PKGCONF ptlib)

# Include dir
find_path(PTLIB_INCLUDE_DIR
  NAMES ptlib.h
  PATHS ${PTLIB_PKGCONF_INCLUDE_DIRS}
)

# Finally the library itself
find_library(PTLIB_LIBRARY
  NAMES ptlib libptlib ptlibs libptlibs ptlibd pt pt_s pt_d ptd ptlibsd 
  PATHS ${PTLIB_PKGCONF_LIBRARY_DIRS}
)

# Set the include dir variables and the libraries and let libfind_process do the rest.
# NOTE: Singular variables for this library, plural for libraries this this lib depends on.
set(PTLIB_PROCESS_INCLUDES PTLIB_INCLUDE_DIR)
set(PTLIB_PROCESS_LIBS PTLIB_LIBRARY)
libfind_process(PTLIB)
