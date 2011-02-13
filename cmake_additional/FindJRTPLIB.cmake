include(LibFindMacros)

# Dependencies
#libfind_package(x264 Magick)

# Use pkg-config to get hints about paths
libfind_pkg_check_modules(JRTPLIB_PKGCONF jrtplib)

# Include dir
find_path(JRTPLIB_INCLUDE_DIR
  NAMES rtppacket.h
  PATHS ${JRTPLIB_PKGCONF_INCLUDE_DIRS} "${CMAKE_PREFIX_PATH}/include/jrtplib3"
)

# Finally the library itself

if (WIN32)
		find_library(JRTPLIB_LIBRARY_RELEASE NAMES jrtplib-s jrtplib_s)
        find_library(JRTPLIB_LIBRARY_DEBUG NAMES jrtplib-sgd jrtplib_sgd)
		set(JRTPLIB_LIBRARY debug ${JRTPLIB_LIBRARY_DEBUG} optimized ${JRTPLIB_LIBRARY_RELEASE})
else()
find_library(JRTPLIB_LIBRARY
  NAMES jrtp libjrtp jrtplib jrtplibd jrtp_d jrtp_s
  PATHS ${JRTPLIB_PKGCONF_LIBRARY_DIRS}
)
endif()

# Set the include dir variables and the libraries and let libfind_process do the rest.
# NOTE: Singular variables for this library, plural for libraries this this lib depends on.
set(JRTPLIB_PROCESS_INCLUDES JRTPLIB_INCLUDE_DIR)
set(JRTPLIB_PROCESS_LIBS JRTPLIB_LIBRARY)
libfind_process(JRTPLIB)
