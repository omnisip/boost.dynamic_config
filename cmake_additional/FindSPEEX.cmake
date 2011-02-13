include(LibFindMacros)



# Use pkg-config to get hints about paths
libfind_pkg_check_modules(SPEEX_PKGCONF speex)

# Include dir
find_path(SPEEX_INCLUDE_DIR
  NAMES speex/speex.h
  PATHS ${SPEEX_PKGCONF_INCLUDE_DIRS}
)

# Finally the library itself
find_library(SPEEX_LIBRARY
  NAMES speex libspeex speexd libspeexd
  PATHS ${SPEEX_PKGCONF_LIBRARY_DIRS} 
)

find_library(SPEEXDSP_LIBRARY
  NAMES speexdsp libspeexdsp speexdspd libspeexdspd
  PATHS ${SPEEX_PKGCONF_LIBRARY_DIRS}
)


set(SPEEX_PROCESS_INCLUDES SPEEX_INCLUDE_DIR)
if (EXISTS SPEEXDSP_ONLY)
  set(SPEEX_PROCESS_LIBS SPEEXDSP_LIBRARY)
else (EXISTS SPEEXDSP_ONLY)
  set(SPEEX_PROCESS_LIBS SPEEX_LIBRARY SPEEXDSP_LIBRARY)
endif (EXISTS SPEEXDSP_ONLY)
libfind_process(SPEEX)