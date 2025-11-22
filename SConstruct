import os
import subprocess
import sysconfig
import numpy as np

arch = subprocess.check_output(["uname", "-m"], encoding='utf8').rstrip()

python_path = sysconfig.get_paths()['include']
cpppath = [
  "opendbc/can",
  '/usr/lib/include',
  python_path
]

AddOption('--kaitai',
          action='store_true',
          help='Regenerate kaitai struct parsers')
          
AddOption('--test',
          action='store_true',
          help='build test files')

AddOption('--asan',
          action='store_true',
          help='turn on ASAN')

AddOption('--ubsan',
          action='store_true',
          help='turn on UBSan')

SHARED = False

home = os.environ['HOME']

lenv = {
  "PATH": os.environ['PATH'] + ":" + Dir(f"#libs/capnpc-java/{arch}/bin").abspath,
  "LD_LIBRARY_PATH": [Dir(f"#third_party/acados/{arch}/lib").abspath],
  "PYTHONPATH": Dir("#").abspath + ":" + Dir("#third_party/acados").abspath,

  "ACADOS_SOURCE_DIR": Dir("#third_party/acados/include/acados").abspath,
  "ACADOS_PYTHON_INTERFACE_PATH": Dir("#third_party/acados/acados_template").abspath,
  "TERA_PATH": Dir("#").abspath + f"/third_party/acados/{arch}/t_renderer",
}

libpath = [
      f"#third_party/acados/{arch}/lib",
      ]

cflags = []
cxxflags = []

rpath = lenv["LD_LIBRARY_PATH"].copy()
rpath += ["/usr/local/lib"]

rpath += [
    Dir("#cereal").abspath,
    Dir("#common").abspath
  ]

if GetOption('asan'):
  ccflags = ["-fsanitize=address", "-fno-omit-frame-pointer"]
  ldflags = ["-fsanitize=address"]
elif GetOption('ubsan'):
  ccflags = ["-fsanitize=undefined"]
  ldflags = ["-fsanitize=undefined"]
else:
  ccflags = []
  ldflags = []

lenv = {
  "PATH": f"{home}/.buildozer/android/platform/android-ndk-r28c/toolchains/llvm/prebuilt/linux-x86_64/bin/:{home}/.venv/bin:/bin:/usr/local/bin/", #os.environ['PATH'],
  "LD_LIBRARY_PATH": [Dir("#").abspath + "/flowy/.buildozer/android/platform/build-arm64-v8a/build/libs_collections/oscservice/arm64-v8a"],
  "PYTHONPATH": Dir("#").abspath + ':' + Dir(f"#third_party/acados").abspath,

  "ACADOS_SOURCE_DIR": Dir("#third_party/acados").abspath,
  "ACADOS_PYTHON_INTERFACE_PATH": Dir("#third_party/acados/acados_template").abspath,
  "TERA_PATH": Dir("#").abspath + f"/third_party/acados/x86_64/t_renderer"
}

cflags = []
cxxflags = []
cpppath = []
rpath = [] #lenv["LD_LIBRARY_PATH"].copy()

libpath = [
  # f"#third_party/acados/{arch}/lib",
  # f"#third_party/libyuv/{arch}/lib",

  # "/usr/lib",
  # "/usr/local/lib",
]


if GetOption('asan'):
  ccflags = ["-fsanitize=address", "-fno-omit-frame-pointer"]
  ldflags = ["-fsanitize=address"]
elif GetOption('ubsan'):
  ccflags = ["-fsanitize=undefined"]
  ldflags = ["-fsanitize=undefined"]
else:
  ccflags = []
  ldflags = ['-llog', '-Wl,--no-undefined']

# Enable swaglog include in submodules
cflags += ['-DSWAGLOG="\\"common/swaglog.h\\""']
cxxflags += ['-DSWAGLOG="\\"common/swaglog.h\\""']

# ccflags_option = GetOption('ccflags')
# if ccflags_option:
#   ccflags += ccflags_option.split(' ')

env = Environment(
  ENV=lenv,
  CCFLAGS=[
    "-g",
    "-fPIC",
    "-O2",
    "-Wunused",
    "-Werror",
    "-Wshadow",
    "-Wno-unknown-warning-option",
    "-Wno-deprecated-register",
    "-Wno-register",
    "-Wno-inconsistent-missing-override",
    "-Wno-c99-designator",
    "-Wno-reorder-init-list",
    "-Wno-error=unused-but-set-variable",
    "-Wno-vla-cxx-extension",
  ] + cflags + ccflags,

  CPPPATH=cpppath + [
    "#",
    "#flowy/.buildozer/android/platform/build-arm64-v8a/build/other_builds/acados/arm64-v8a__ndk_target_24/acados",
    "#flowy/.buildozer/android/platform/build-arm64-v8a/build/other_builds/acados/arm64-v8a__ndk_target_24/acados/external/blasfeo/include",
    "#flowy/.buildozer/android/platform/build-arm64-v8a/build/other_builds/acados/arm64-v8a__ndk_target_24/acados/external/hpipm/include",
    "#flowy/.buildozer/android/platform/build-arm64-v8a/build/other_builds/acados/arm64-v8a__ndk_target_24/acados/external",
    "#flowy/.buildozer/android/platform/build-arm64-v8a/build/other_builds/acados/arm64-v8a__ndk_target_24/acados/interfaces",
    "#third_party/libusb",
    "#third_party/json11",
    "#third_party/opencl/include",
    "#third_party/linux/include",
    "#third_party/lmdb",
    "#third_party",
    "#selfdrive/modeld",
    "#cereal",
    "#common",
    "#msgq",
    "#opendbc/can",
    "#flowy/.buildozer/android/platform/build-arm64-v8a/build/other_builds/capnp/arm64-v8a__ndk_target_24/capnp/c++/src/",
    "#flowy/.buildozer/android/platform/build-arm64-v8a/build/other_builds/libzmq/arm64-v8a__ndk_target_24/libzmq/include/",
    "#flowy/.buildozer/android/platform/build-arm64-v8a/build/other_builds/python3/arm64-v8a__ndk_target_24/python3/Include/",
    "#flowy/.buildozer/android/platform/build-arm64-v8a/build/python-installs/oscservice/arm64-v8a/numpy/core/include/",
  ],

  CC=f'clang --target=aarch64-linux-android24 --sysroot={home}/.buildozer/android/platform/android-ndk-r28c/toolchains/llvm/prebuilt/linux-x86_64/sysroot',
  CXX=f'clang++ --target=aarch64-linux-android24 --sysroot={home}/.buildozer/android/platform/android-ndk-r28c/toolchains/llvm/prebuilt/linux-x86_64/sysroot',
  LINKFLAGS=ldflags,
  AR='llvm-ar',
  RANLIB='llvm-ranlib',
  LD='llvm-ld',

  RPATH=rpath,

  CFLAGS=["-std=gnu11"] + cflags,
  CXXFLAGS=["-std=c++17"] + cxxflags,
  LIBPATH=libpath + [
    "#msgq_repo",
    "#third_party",
    "#third_party/json11",
    "#third_party/libusb/android/libs/arm64-v8a",
    "#third_party/CL",
    "#third_party/lmdb",
    "#selfdrive/pandad",
    "#common",
    "#cereal",
    "#selfdrive/modeld",
    "#rednose/helpers",
    "#flowy/.buildozer/android/platform/build-arm64-v8a/build/libs_collections/openpilot/arm64-v8a/",
    "#flowy/.buildozer/android/platform/build-arm64-v8a/build/other_builds/python3/arm64-v8a__ndk_target_24/python3/android-build",
  ],
  CYTHONCFILESUFFIX=".cpp",
  COMPILATIONDB_USE_ABSPATH=True,
  # REDNOSE_ROOT="#",
  tools=["default", "cython"],
  toolpath = ['opendbc/site_scons/site_tools'],
)

# Cython build enviroment
py_include = "flowy/.buildozer/android/platform/build-arm64-v8a/build/other_builds/python3/arm64-v8a__ndk_target_24/python3/Include/" # sysconfig.get_paths()['include']
envCython = env.Clone()
envCython["CPPPATH"] += [py_include] #, np.get_include()]
envCython["CCFLAGS"] += ["-Wno-#warnings", "-Wno-shadow", "-Wno-deprecated-declarations"]
envCython["CCFLAGS"].remove("-Werror")

envCython["LIBS"] = ['python3.11']
if arch == "Darwin":
  envCython["LINKFLAGS"] = ["-bundle", "-undefined", "dynamic_lookup"] + darwin_rpath_link_flags
else:
  envCython["LINKFLAGS"] = ["-pthread", "-shared"]

Export('envCython')

QCOM_REPLAY = False
Export('env', 'arch', 'QCOM_REPLAY', 'SHARED')

SConscript(['common/SConscript'])
Import('_common', '_gpucommon')

common = [_common, 'json11', 'lmdb']
gpucommon = _gpucommon

Export('common', 'gpucommon')

envCython = env.Clone()
envCython["CPPPATH"] += [np.get_include()]
envCython["CCFLAGS"] += ["-Wno-#warnings", "-Wno-shadow", "-Wno-deprecated-declarations"]

python_libs = []
if arch == "Darwin":
  envCython["LINKFLAGS"] = ["-bundle", "-undefined", "dynamic_lookup"]
elif arch == "aarch64":
  envCython["LINKFLAGS"] = ["-shared"]

  python_libs.append(os.path.basename(python_path))
else:
  envCython["LINKFLAGS"] = ["-pthread", "-shared"]

envCython["LIBS"] = ['python3.11']

Export('envCython')


# cereal and messaging are shared with the system
SConscript(['cereal/SConscript'])
# if SHARED:
#   cereal = abspath([File('cereal/libcereal_shared.so')])
#   messaging = abspath([File('cereal/libmessaging_shared.so')])
# else:

# Export('cereal', 'messaging')

# # Build rednose library and ekf models

# rednose_deps = [
#   "#selfdrive/locationd/models/constants.py",
#   "#selfdrive/locationd/models/gnss_helpers.py",
# ]

# rednose_config = {
#   'generated_folder': '#selfdrive/locationd/models/generated',
#   'to_build': {
#     'gnss': ('#selfdrive/locationd/models/gnss_kf.py', True, [], rednose_deps),
#     'live': ('#selfdrive/locationd/models/live_kf.py', True, ['live_kf_constants.h'], rednose_deps),
#     'car': ('#selfdrive/locationd/models/car_kf.py', True, [], rednose_deps),
#   },
# }

# if arch != "larch64":
#   rednose_config['to_build'].update({
#     'loc_4': ('#selfdrive/locationd/models/loc_kf.py', True, [], rednose_deps),
#     'lane': ('#selfdrive/locationd/models/lane_kf.py', True, [], rednose_deps),
#     'pos_computer_4': ('#rednose/helpers/lst_sq_computer.py', False, [], []),
#     'pos_computer_5': ('#rednose/helpers/lst_sq_computer.py', False, [], []),
#     'feature_handler_5': ('#rednose/helpers/feature_handler.py', False, [], []),
#   })

# Export('rednose_config')
# SConscript(['rednose/SConscript'])

SConscript(['third_party/SConscript'])

# SConscript([
#   'system/clocksd/SConscript',
# ])

# build submodules
SConscript([
  'opendbc/can/SConscript',
  'panda/SConscript',
])

# SConscript(['SConscript'])

# SConscript(['system/proclogd/SConscript'])

SConscript(['common/kalman/SConscript'])
SConscript(['common/transformations/SConscript'])

SConscript(['selfdrive/modeld/SConscript'])
SConscript(['wrappers/SConscript'])

SConscript(['selfdrive/controls/lib/lateral_mpc_lib/SConscript'])
SConscript(['selfdrive/controls/lib/longitudinal_mpc_lib/SConscript'])

# SConscript(['selfdrive/locationd/SConscript'])
SConscript(['selfdrive/boardd/SConscript'])
SConscript(['selfdrive/loggerd/SConscript'])

# if GetOption('test'):
#   SConscript('panda/tests/safety/SConscript')
