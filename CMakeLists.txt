project(boost.dynamic_config)
cmake_minimum_required(VERSION 2.6)

include_directories("${CMAKE_CURRENT_SOURCE_DIR}/include")

FILE(GLOB_RECURSE DYNAMIC_CONFIG_HEADERS "${CMAKE_CURRENT_SOURCE_DIR}/include/*.hpp")

source_group(DynamicConfigHeaders FILES ${DYNAMIC_CONFIG_HEADERS})

add_executable(test-main test-main.cpp)