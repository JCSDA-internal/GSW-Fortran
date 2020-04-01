#
# GSW
# Copyright and License: see LICENSE

cmake_minimum_required( VERSION 3.12 )
project( gsw LANGUAGES Fortran )

## Ecbuild integration
include( ecbuild_system NO_POLICY_SCOPE )
ecbuild_declare_project()
list( APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake )
set( CMAKE_DIRECTORY_LABELS ${PROJECT_NAME} )

## Configuration options
include( ${PROJECT_NAME}_compiler_flags )

## Sources
add_subdirectory(modules)
add_subdirectory(toolbox)
add_subdirectory(test)

list ( APPEND ${PROJECT_NAME}_src_files
    ${gsw_modules_files}
    ${gsw_toolbox_files}
)

ecbuild_add_library( TARGET   ${PROJECT_NAME}
                     SOURCES  ${${PROJECT_NAME}_src_files}
                     LINKER_LANGUAGE Fortran )

#Fortran module output directory for build and install interfaces
set(MODULE_DIR module/${PROJECT_NAME}/${CMAKE_Fortran_COMPILER_ID}/${CMAKE_Fortran_COMPILER_VERSION})
set_target_properties(${PROJECT_NAME} PROPERTIES Fortran_MODULE_DIRECTORY ${CMAKE_BINARY_DIR}/${MODULE_DIR})
install(DIRECTORY ${CMAKE_BINARY_DIR}/${MODULE_DIR}/ DESTINATION ${MODULE_DIR})
target_include_directories(${PROJECT_NAME} INTERFACE
                                $<BUILD_INTERFACE:${CMAKE_BINARY_DIR}/${MODULE_DIR}>
                                $<INSTALL_INTERFACE:${CMAKE_INSTALL_PREFIX}/${MODULE_DIR}>)

## Package Config
ecbuild_install_project( NAME ${PROJECT_NAME} )

ecbuild_print_summary()
