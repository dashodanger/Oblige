cmake_minimum_required(VERSION 3.18)
set(CMAKE_C_STANDARD 99)
set(CMAKE_CXX_STANDARD 11)

project(
  filename_formatter
  VERSION 0.1.0
  LANGUAGES C CXX
)
add_executable(${PROJECT_NAME} ${SOURCES} main.cpp lex.yy.c)
# Workaround for cross-compiling until I do something more elegant. Still need
# flex installed - Dasho
if(!MINGW)
  find_package(FLEX REQUIRED)
endif()
target_link_libraries(${PROJECT_NAME} PRIVATE ${FLEX_LIBRARIES})
