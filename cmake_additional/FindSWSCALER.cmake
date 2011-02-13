include(LibFindMacros)

# Dependencies
#libfind_package(x264 Magick)

# Use pkg-config to get hints about paths
libfind_pkg_check_modules(SWSCALER_PKGCONF libswscale)

# Include dir
find_path(SWSCALER_INCLUDE_DIR
  NAMES libswscale/swscale.h 
  PATHS ${SWSCALER_PKGCONF_INCLUDE_DIRS}
)

# Finally the library itself
find_library(SWSCALER_LIBRARY
  NAMES swscale libswscale swscaler libswscaler 
  PATHS ${SWSCALER_PKGCONF_LIBRARY_DIRS}
)

# Set the include dir variables and the libraries and let libfind_process do the rest.
# NOTE: Singular variables for this library, plural for libraries this this lib depends on.
set(SWSCALER_PROCESS_INCLUDES SWSCALER_INCLUDE_DIR)
set(SWSCALER_PROCESS_LIBS  SWSCALER_LIBRARY)
libfind_process(SWSCALER)
