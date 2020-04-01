
list( APPEND gsw_test_data
    gsw_data_v3_0.nc
)

foreach( _file IN LISTS gsw_test_data )
    execute_process( COMMAND ${CMAKE_COMMAND} -E create_symlink
           ${CMAKE_CURRENT_SOURCE_DIR}/${_file}
           ${CMAKE_CURRENT_BINARY_DIR}/${_file} )
endforeach()

list( APPEND gsw_test_files
    gsw_poly_check.f90
    gsw_check_functions.f90
)

foreach( _file IN LISTS gsw_test_files )
    string( REPLACE ".f90" "" _name ${_file} )
    ecbuild_add_test(TARGET ${_name} SOURCES ${_file} LIBS ${PROJECT_NAME})
endforeach()
