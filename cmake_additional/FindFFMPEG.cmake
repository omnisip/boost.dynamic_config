include(LibFindMacros)

# Dependencies
#libfind_package(x264 Magick)

# Use pkg-config to get hints about paths
libfind_pkg_check_modules(AVCODEC_PKGCONF libavcodec)
libfind_pkg_check_modules(POSTPROC_PKGCONF libpostproc)
if (AVCODEC_PKGCONF_FOUND AND POSTPROC_PKGCONF_FOUND)
  MESSAGE("Using pkg-config libavcodec")
  set(FFMPEG_PROCESS_INCLUDES AVCODEC_PKGCONF_INCLUDE_DIRS POSTPROC_PKGCONF_INCLUDE_DIRS)
  set(FFMPEG_PROCESS_LIBS POSTPROC_PKGCONF_LIBRARIES AVCODEC_PKGCONF_LIBRARIES )
  link_directories(${AVCODEC_PKGCONF_LIBRARY_DIRS})
  link_directories(${POSTPROC_PKGCONF_LIBRARY_DIRS})
  
else()
  find_path(AVCODEC_INCLUDE_DIR
    NAMES libavcodec/avcodec.h
    PATHS ${AVCODEC_PKGCONF_INCLUDE_DIRS}
  )

# Finally the library itself
  find_library(AVCODEC_LIBRARY
    NAME avcodec libavcodec avcodecd libavcodecd
    PATHS ${AVCODEC_PKGCONF_LIBRARY_DIRS}
  )

  find_library(AVUTIL_LIBRARY NAME avutil libavutil avutild libavutild PATHS ${AVCODEC_PKGCONF_LIBRARY_DIRS})
  find_library(AVCORE_LIBRARY NAME avcore libavcore avcored libavcored PATHS ${AVCODEC_PKGCONF_LIBRARY_DIRS})


  # Set the include dir variables and the libraries and let libfind_process do the rest.
  # NOTE: Singular variables for this library, plural for libraries this this lib depends on.
  set(FFMPEG_PROCESS_INCLUDES AVCODEC_INCLUDE_DIR)
  if (EXISTS AVCORE_LIBRARY)
    set(FFMPEG_PROCESS_LIBS AVCODEC_LIBRARY AVUTIL_LIBRARY AVCORE_LIBRARY)
  else()
    set(FFMPEG_PROCESS_LIBS  AVCODEC_LIBRARY AVUTIL_LIBRARY)
  endif()
endif()
# Include dir

libfind_process(FFMPEG)
