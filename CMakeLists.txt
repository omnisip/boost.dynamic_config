project(boost.dynamic_config)
cmake_minimum_required(VERSION 2.6)
SET(CMAKE_VERBOSE_MAKEFILE ON)
SET(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake_additional/")
if (WIN32)
	SET(CMAKE_PREFIX_PATH "C:/Developer/Marketsoup")
	link_directories("${CMAKE_PREFIX_PATH}/lib"
					 "${CMAKE_PREFIX_PATH}/bin")
	include_directories("C:/Developer/Marketsoup/include")
	add_definitions("-D_WIN32_WINNT=0x0501")
	add_definitions("-DWIN32")
	add_definitions("-DBOOST_ASIO_ENABLE_CANCELIO=1")
	add_definitions("-DASIO_ENABLE_CANCELIO=1")
	add_definitions("-DBOOST_ALL_NO_LIB -D_SCL_SECURE_NO_WARNINGS")
	if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Intel"
        OR "${CMAKE_CXX_COMPILER}" MATCHES "icl" 
        OR "${CMAKE_CXX_COMPILER}" MATCHES "icpc")
		
		add_definitions("/Qstd=c++0x")
	endif()
endif()

if (CMAKE_COMPILER_IS_GNUCC)
    execute_process(COMMAND ${CMAKE_C_COMPILER} -dumpversion
                    OUTPUT_VARIABLE GCC_VERSION)
    string(REGEX MATCHALL "[0-9]+" GCC_VERSION_COMPONENTS ${GCC_VERSION})
    list(GET GCC_VERSION_COMPONENTS 0 GCC_MAJOR)
    list(GET GCC_VERSION_COMPONENTS 1 GCC_MINOR)

    message(STATUS "GCC Version: ${GCC_VERSION}")

    add_definitions("-Wall")
    #add_definitions("-Wextra")
  add_definitions("-fPIC")
endif()


if (CMAKE_COMPILER_IS_GNUCC AND ((GCC_MAJOR EQUAL 4 AND GCC_MINOR GREATER 3) OR GCC_MAJOR GREATER 4 ))
  # Note unnecessary add of -D parameter, but it may help kdevelop
  add_definitions("-D__GXX_EXPERIMENTAL_CXX0X__=1")
  set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++0x")
  if (CMAKE_BUILD_TYPE STREQUAL "Debug")
	set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fprofile-arcs -ftest-coverage")
        set (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fprofile-arcs -ftest-coverage")
        set (CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -fprofile-arcs -ftest-coverage")
  endif()
  MESSAGE(STATUS "Successfully turned on C++0x support")
endif()

find_package(Threads REQUIRED)
if(WIN32)
set(Boost_USE_STATIC_LIBS        ON)
set(Boost_USE_MULTITHREADED      ON)
find_package(Boost COMPONENTS program_options thread system REQUIRED)
else()
find_package(Boost COMPONENTS thread system program_options REQUIRED)
endif()


include_directories("${CMAKE_CURRENT_SOURCE_DIR}/include")

FILE(GLOB_RECURSE DYNAMIC_CONFIG_HEADERS "${CMAKE_CURRENT_SOURCE_DIR}/include/*.hpp")

source_group(DynamicConfigHeaders FILES ${DYNAMIC_CONFIG_HEADERS})

add_executable(test-main test-main.cpp ${DYNAMIC_CONFIG_HEADERS})