include(LibFindMacros)

# Dependencies
#libfind_package(x264 Magick)

# Use pkg-config to get hints about paths
libfind_pkg_check_modules(JTHREAD_PKGCONF jthread)

# Include dir
find_path(JTHREAD_INCLUDE_DIR
  NAMES jmutex.h
  PATHS ${JTHREAD_PKGCONF_INCLUDE_DIRS} "${CMAKE_PREFIX_PATH}/include/jthread"
)

# Finally the library itself
if (WIN32)
	find_library(JTHREAD_LIBRARY_DEBUG NAMES jthread-sgd jthread_sgd)
    find_library(JTHREAD_LIBRARY_RELEASE NAMES jthread-s jthread_s)
	SET(JTHREAD_LIBRARY debug ${JTHREAD_LIBRARY_DEBUG} optimized ${JTHREAD_LIBRARY_RELEASE})
else()
find_library(JTHREAD_LIBRARY
  NAMES jthread libjthread
  PATHS ${JTHREAD_PKGCONF_LIBRARY_DIRS}
)
endif()

# Set the include dir variables and the libraries and let libfind_process do the rest.
# NOTE: Singular variables for this library, plural for libraries this this lib depends on.
set(JTHREAD_PROCESS_INCLUDES JTHREAD_INCLUDE_DIR)
set(JTHREAD_PROCESS_LIBS JTHREAD_LIBRARY)
libfind_process(JTHREAD)
