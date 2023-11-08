
if(NOT "/home/ga4o/SDP/sdp/sdp-2023-24/homework/hw1/template/build/_deps" IS_NEWER_THAN "/home/ga4o/SDP/sdp/sdp-2023-24/homework/hw1/template/build/_deps/catch2-subbuild/catch2-populate-prefix/src/catch2-populate-stamp/catch2-populate-gitinfo.txt")
  message(STATUS "Avoiding repeated git clone, stamp file is up to date: '/home/ga4o/SDP/sdp/sdp-2023-24/homework/hw1/template/build/_deps/catch2-subbuild/catch2-populate-prefix/src/catch2-populate-stamp/catch2-populate-gitinfo.txt'")
  return()
endif()

execute_process(
  COMMAND ${CMAKE_COMMAND} -E rm -rf "/home/ga4o/SDP/sdp/sdp-2023-24/homework/hw1/template/build/_deps/catch2-src"
  RESULT_VARIABLE error_code
  )
if(error_code)
  message(FATAL_ERROR "Failed to remove directory: '/home/ga4o/SDP/sdp/sdp-2023-24/homework/hw1/template/build/_deps/catch2-src'")
endif()

# try the clone 3 times in case there is an odd git clone issue
set(error_code 1)
set(number_of_tries 0)
while(error_code AND number_of_tries LESS 3)
  execute_process(
    COMMAND "/usr/bin/git"  clone --no-checkout --origin "FIND_PACKAGE_ARGS" "https://github.com/catchorg/Catch2.git" "advice.detachedHead=false"
    WORKING_DIRECTORY "catch2-src"
    RESULT_VARIABLE error_code
    )
  math(EXPR number_of_tries "${number_of_tries} + 1")
endwhile()
if(number_of_tries GREATER 1)
  message(STATUS "Had to git clone more than once:
          ${number_of_tries} times.")
endif()
if(error_code)
  message(FATAL_ERROR "Failed to clone repository: 'https://github.com/catchorg/Catch2.git'")
endif()

execute_process(
  COMMAND "/usr/bin/git"  checkout v3.4.0 --
  WORKING_DIRECTORY "catch2-src/advice.detachedHead=false"
  RESULT_VARIABLE error_code
  )
if(error_code)
  message(FATAL_ERROR "Failed to checkout tag: 'v3.4.0'")
endif()

set(init_submodules origin)
if(init_submodules)
  execute_process(
    COMMAND "/usr/bin/git"  submodule update TRUE --init --recursive
    WORKING_DIRECTORY "catch2-src/advice.detachedHead=false"
    RESULT_VARIABLE error_code
    )
endif()
if(error_code)
  message(FATAL_ERROR "Failed to update submodules in: 'catch2-src/advice.detachedHead=false'")
endif()

# Complete success, update the script-last-run stamp file:
#
execute_process(
  COMMAND ${CMAKE_COMMAND} -E copy
    "/home/ga4o/SDP/sdp/sdp-2023-24/homework/hw1/template/build/_deps"
    "/home/ga4o/SDP/sdp/sdp-2023-24/homework/hw1/template/build/_deps/catch2-subbuild/catch2-populate-prefix/src/catch2-populate-stamp/catch2-populate-gitinfo.txt"
  RESULT_VARIABLE error_code
  )
if(error_code)
  message(FATAL_ERROR "Failed to copy script-last-run stamp file: '/home/ga4o/SDP/sdp/sdp-2023-24/homework/hw1/template/build/_deps/catch2-subbuild/catch2-populate-prefix/src/catch2-populate-stamp/catch2-populate-gitinfo.txt'")
endif()

