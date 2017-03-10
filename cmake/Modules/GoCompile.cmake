# Copyright (C) 2017 Google Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

include(${GO_ENV})

get_filename_component(path ${GO_BUILD} DIRECTORY)
get_filename_component(parent ${path} NAME)
set(command "build")
set(args
    "-pkgdir" "${GO_PKG}"
    "-o" "${GO_BUILD}"
    "-i"
)
if(parent STREQUAL "test")
    set(command "test")
    list(APPEND args "-c")
endif()
if(NOT BUILDBOT)
    list(APPEND args "-tags" "integration")
endif()
execute_process(
    COMMAND "${CMAKE_Go_COMPILER}" ${command} ${args} ${GO_EXTRA_ARGS} ${GO_PACKAGE}
    RESULT_VARIABLE result
)
if(result)
    message(FATAL_ERROR ${result})
endif()
