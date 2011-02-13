

include(LibFindMacros)

# Use pkg-config to get hints about paths
libfind_pkg_check_modules(PORTAUDIO_PKGCONF portaudiocpp)

# Include dir
find_path(PORTAUDIO_INCLUDE_DIR
  NAMES portaudio.h
  PATHS ${PORTAUDIO_PKGCONF_INCLUDE_DIRS}
)


if (WIN32)
	FIND_LIBRARY(PORTAUDIO_C_LIBRARY_RELEASE portaudio libportaudio portaudio-s portaudio_s libportaudio_s libportaudio-s)
	FIND_LIBRARY(PORTAUDIO_C_LIBRARY_DEBUG portaudio-gd libportaudio-gd portaudio_gd libportaudio-gd portaudio-sgd portaudio_sgd libportaudio-sgd libportaudio_sgd)
	SET(PORTAUDIO_C_LIBRARY debug ${PORTAUDIO_C_LIBRARY_DEBUG} optimized ${PORTAUDIO_C_LIBRARY_RELEASE})
	set(PORTAUDIO_PROCESS_LIBS PORTAUDIO_C_LIBRARY)
else()
FIND_LIBRARY(PORTAUDIO_C_LIBRARY NAMES portaudio libportaudio portaudiod libportaudiod PATH ${PORTAUDIO_PKGCONF_LIBRARY_DIRS})
FIND_LIBRARY(PORTAUDIO_CPP_LIBRARY NAMES portaudiocpp libportaudiocpp portaudiocppd libportaudiocppd PATH ${PORTAUDIO_PKGCONF_LIBRARY_DIRS})

# Set the include dir variables and the libraries and let libfind_process do the rest.
# NOTE: Singular variables for this library, plural for libraries this this lib depends on.
set(PORTAUDIO_PROCESS_LIBS PORTAUDIO_CPP_LIBRARY PORTAUDIO_C_LIBRARY )
endif()
set(PORTAUDIO_PROCESS_INCLUDES PORTAUDIO_INCLUDE_DIR)
libfind_process(PORTAUDIO)
