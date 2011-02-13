include(LibFindMacros)

# Dependencies
#libfind_package(x264 Magick)

# Use pkg-config to get hints about paths
libfind_pkg_check_modules(TBB_PKGCONF tbb)

# Include dir
find_path(TBB_INCLUDE_DIR
  NAMES tbb/atomic.h
  PATHS ${TBB_PKGCONF_INCLUDE_DIRS}
)

# Finally the library itself
find_library(TBB_LIBRARY
  NAMES tbb libtbb tbb_debug tbb-debug libtbb_debug libtbb-debug
  PATHS ${TBB_PKGCONF_LIBRARY_DIRS}
)

find_library(TBB_MALLOC_LIBRARY
  NAMES tbbmalloc libtbbmalloc tbbmalloc_debug libtbbmalloc_debug tbbmalloc-debug libtbbmalloc-debug
  PATHS ${TBB_PKGCONF_LIBRARY_DIRS}
)

find_library(TBB_MALLOC_PROXY_LIBRARY
	NAMES tbbmalloc_proxy
        PATHS ${TBB_PKGCONF_LIBRARY_DIRS}
)

#if (WIN32)
#	find_library(PTHREADS_LIBRARY NAMES pthreadVC2 libpthreadVC2 PATHS
#			 ${X264_PKGCONF_LIBRARY_DIRS}
#	)
#endif (WIN32)



# Set the include dir variables and the libraries and let libfind_process do the rest.
# NOTE: Singular variables for this library, plural for libraries this this lib depends on.
set(TBB_PROCESS_INCLUDES TBB_INCLUDE_DIR)
#if (WIN32)
#	set(X264_PROCESS_LIBS X264_LIBRARY PTHREADS_LIBRARY)
#else (WIN32)
	set(TBB_PROCESS_LIBS TBB_LIBRARY TBB_MALLOC_LIBRARY TBB_MALLOC_PROXY_LIBRARY)
#endif (WIN32)
libfind_process(TBB)
