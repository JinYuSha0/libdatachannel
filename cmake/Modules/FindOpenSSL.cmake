set(OPENSSL_INCLUDE_DIR /usr/local/opt/openssl@3/include)

set(OpenSSL_LIBRARIY_SSL /usr/local/opt/openssl@3/lib/libssl.a)
set(OpenSSL_LIBRARY_CRYPRO /usr/local/opt/openssl@3/lib/libcrypto.a)
set(OpenSSL_LIBRARIES ${OpenSSL_LIBRARIY_SSL} ${OpenSSL_LIBRARY_CRYPRO})

mark_as_advanced(OPENSSL_INCLUDE_DIR)
mark_as_advanced(OpenSSL_LIBRARIES)

include(FindPackageHandleStandardArgs)

find_package_handle_standard_args("OpenSSL"
  DEFAULT_MSG
  OPENSSL_INCLUDE_DIR
  OpenSSL_LIBRARIES
)

if(NOT TARGET OpenSSL::Crypto)
  add_library(OpenSSL::Crypto STATIC IMPORTED)
  set_target_properties(OpenSSL::Crypto PROPERTIES
    INTERFACE_INCLUDE_DIRECTORIES "${OpenSSL_INCLUDE_DIR}"
  )
  set_target_properties(OpenSSL::Crypto PROPERTIES
    IMPORTED_LOCATION "${OpenSSL_LIBRARY_CRYPRO}"
  )
endif()

if(NOT TARGET OpenSSL::SSL)
  add_library(OpenSSL::SSL STATIC IMPORTED)
  set_target_properties(OpenSSL::SSL PROPERTIES
    INTERFACE_INCLUDE_DIRECTORIES "${OPENSSL_INCLUDE_DIR}"
    INTERFACE_LINK_LIBRARIES OpenSSL::Crypto
  )
  set_target_properties(OpenSSL::SSL PROPERTIES
    IMPORTED_LOCATION "${OpenSSL_LIBRARIY_SSL}"
  )
endif()
