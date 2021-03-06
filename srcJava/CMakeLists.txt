# Copyright 2006-2008 The FLWOR Foundation.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# all external module libraries are generated in the directory
# of the corresponding .xq file
MESSAGE(STATUS "Add srcJava")

# Java

find_package( Java)
set( NON_NATIVE_TARGET TRUE)


# Verbose makefile
set( CMAKE_VERBOSE_MAKEFILE TRUE)


set( JAR_NAME ${PROJECT_NAME}-${SCHEMA_TOOLS_VERSION}.jar )
set( CMAKE_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR})

# find all java source files
file(GLOB_RECURSE JAVA_SOURCE_FILES RELATIVE "${CMAKE_CURRENT_SOURCE_DIR}"
    "${CMAKE_CURRENT_SOURCE_DIR}/*.java")

IF (WIN32)
  set( JAVA_CLASS_PATH
    ${JAVA_CLASS_PATH};${XMLBEANS_JAR}
    )
ELSE (WIN32)
  set( JAVA_CLASS_PATH
    ${JAVA_CLASS_PATH}:${XMLBEANS_JAR}
    )
ENDIF (WIN32)

# Compile all java files
add_custom_target( ${PROJECT_NAME}.jar.classes
   COMMAND ${JAVA_COMPILE} -d ${CMAKE_CURRENT_BINARY_DIR}
           -cp ${JAVA_CLASS_PATH}
           ${JAVA_SOURCE_FILES}
   WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
   SOURCES ${JAVA_SOURCE_FILES})
add_dependencies(${PROJECT_NAME}.jar.classes  ${JAVA_SOURCE_FILES})



# jar all class files into a big jar
add_custom_command(
  OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/${JAR_NAME}
  COMMAND ${JAVA_ARCHIVE} cvf ${JAR_NAME} org
  DEPENDS ${PROJECT_NAME}.jar.classes
  WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} )

add_custom_target( ${JAR_NAME} ALL
  DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/${JAR_NAME} )

# add Jar dependencies
DECLARE_ZORBA_JAR(FILE ${CMAKE_CURRENT_BINARY_DIR}/${JAR_NAME}
  TARGET ${JAR_NAME})
DECLARE_ZORBA_JAR(FILE ${XMLBEANS_JAR} EXTERNAL)

MESSAGE(STATUS "End srcJava")