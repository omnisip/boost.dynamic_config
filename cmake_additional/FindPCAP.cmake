include(LibFindMacros)


# Use pkg-config to get hints about paths
libfind_pkg_check_modules(PCAP_PKGCONF pcap)

# Include dir
find_path(PCAP_INCLUDE_DIR
  NAMES pcap.h
  PATHS ${PCAP_PKGCONF_INCLUDE_DIRS} /usr/include /usr/local/include
)

# Finally the library itself
find_library(PCAP_LIBRARY
  NAMES pcap
  PATHS ${PCAP_PKGCONF_LIBRARY_DIRS} /usr/lib /lib /usr/local/lib /usr/lib64 /usr/local/lib64 /lib64
)

# Set the include dir variables and the libraries and let libfind_process do the rest.
# NOTE: Singular variables for this library, plural for libraries this this lib depends on.
set(PCAP_PROCESS_INCLUDES PCAP_INCLUDE_DIR)
set(PCAP_PROCESS_LIBS PCAP_LIBRARY)
libfind_process(PCAP)

