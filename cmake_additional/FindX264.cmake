include(LibFindMacros)

# Dependencies
#libfind_package(x264 Magick)

# Use pkg-config to get hints about paths
libfind_pkg_check_modules(X264_PKGCONF x264)

# Include dir
find_path(X264_INCLUDE_DIR
  NAMES x264.h
  PATHS ${X264_PKGCONF_INCLUDE_DIRS}
)

# Finally the library itself
find_library(X264_LIBRARY
  NAMES x264 libx264 
  PATHS ${X264_PKGCONF_LIBRARY_DIRS}
)

#if (WIN32)
#	find_library(PTHREADS_LIBRARY NAMES pthreadVC2 libpthreadVC2 PATHS
#			 ${X264_PKGCONF_LIBRARY_DIRS}
#	)
#endif (WIN32)



# Set the include dir variables and the libraries and let libfind_process do the rest.
# NOTE: Singular variables for this library, plural for libraries this this lib depends on.
set(X264_PROCESS_INCLUDES X264_INCLUDE_DIR)
#if (WIN32)
#	set(X264_PROCESS_LIBS X264_LIBRARY PTHREADS_LIBRARY)
#else (WIN32)
	set(X264_PROCESS_LIBS X264_LIBRARY)
#endif (WIN32)
libfind_process(X264)
