#!/bin/bash

# Habilitar logs con timestamp
LOG_FILE="/tmp/library_generation.log"
exec > >(tee -a "$LOG_FILE")
exec 2>&1
echo "==============================================="
echo "Iniciando library_generation.sh - $(date)"
echo "==============================================="

PLATFORMS=()
while getopts "p:" o; do
    case "$o" in
        p)
            PLATFORMS+=(${OPTARG})
            ;;
    esac
done

if [ $OPTIND -eq 1 ]; then
    echo "[LOG] Sin argumentos. Usando plataformas por defecto..."
    PLATFORMS+=("opencr1")
    PLATFORMS+=("teensy4")
    PLATFORMS+=("teensy32")
    PLATFORMS+=("teensy35")
    PLATFORMS+=("teensy36")
    PLATFORMS+=("cortex_m0")
    PLATFORMS+=("cortex_m3")
    PLATFORMS+=("cortex_m4")
    # PLATFORMS+=("portenta-m4")
    PLATFORMS+=("portenta-m7")
    PLATFORMS+=("kakutef7-m7")
    PLATFORMS+=("esp32")
    PLATFORMS+=("esp32s3")
else
    echo "[LOG] Argumentos personalizados detectados"
fi
echo "[LOG] Plataformas a compilar: ${PLATFORMS[@]}"

shift $((OPTIND-1))

######## Init ########
echo "[LOG] ========== SECCIÓN: Init =========="
echo "[LOG] Actualizando paquetes del sistema..."
apt update

echo "[LOG] Cambiando a directorio /uros_ws"
cd /uros_ws

echo "[LOG] Inicializando ROS2 con distro: $ROS_DISTRO"
source /opt/ros/$ROS_DISTRO/setup.bash
source install/local_setup.bash

echo "[LOG] Creando firmware workspace..."
ros2 run micro_ros_setup create_firmware_ws.sh generate_lib
echo "[LOG] Firmware workspace creado"

######## Adding extra packages ########
echo "[LOG] ========== SECCIÓN: Adding extra packages =========="
echo "[LOG] Entrando a directorio: firmware/mcu_ws"
pushd firmware/mcu_ws > /dev/null

    echo "[LOG] Clonando geometry2 desde GitHub..."
    # Workaround: Copy just tf2_msgs
    git clone -b iron https://github.com/ros2/geometry2
    if [ -d "geometry2" ]; then
        echo "[LOG] Copiando tf2_msgs a ros2/tf2_msgs"
        cp -R geometry2/tf2_msgs ros2/tf2_msgs
        rm -rf geometry2
        echo "[LOG] geometry2 eliminado"
    else
        echo "[ERROR] Fallo al clonar geometry2"
    fi

    # Import user defined packages
    echo "[LOG] Creando directorio extra_packages"
    mkdir -p extra_packages

    pushd extra_packages > /dev/null
        echo "[LOG] Entrando a directorio: extra_packages"

        echo "[LOG] Copiando paquetes desde /project/extras/library_generation/extra_packages/"
        if [ -d "/project/extras/library_generation/extra_packages" ]; then
            echo "[LOG] Mostrando contenido del directorio source:"
            ls -la /project/extras/library_generation/extra_packages/ | head -20
            echo "[LOG] Copiando archivos..."
            cp -R /project/extras/library_generation/extra_packages/* . 2>/dev/null || echo "[WARN] Posible error copiando paquetes"
            echo "[LOG] Paquetes copiados"
        else
            echo "[ERROR] Directorio source no existe: /project/extras/library_generation/extra_packages"
        fi

        echo "[LOG] Contenido del directorio extra_packages DESPUÉS de copiar:"
        ls -la | head -20

        if [ -f "extra_packages.repos" ]; then
            echo "[LOG] Importando paquetes desde extra_packages.repos..."
            vcs import --input extra_packages.repos
            echo "[LOG] Importación de vcs completada"
        else
            echo "[WARN] Archivo extra_packages.repos no encontrado"
        fi
    popd > /dev/null
    echo "[LOG] Saliendo de directorio: extra_packages"

popd > /dev/null
echo "[LOG] Saliendo de directorio: firmware/mcu_ws"

######## Clean and source ########
find /project/src/ ! -name micro_ros_arduino.h ! -name *.c ! -name *.cpp ! -name *.c.in ! -name micro_ros_kaia.h -delete

######## Build for OpenCR  ########
if [[ " ${PLATFORMS[@]} " =~ " opencr1 " ]]; then
    rm -rf firmware/build

    export TOOLCHAIN_PREFIX=/uros_ws/gcc-arm-none-eabi-5_4-2016q2/bin/arm-none-eabi-
    ros2 run micro_ros_setup build_firmware.sh /project/extras/library_generation/opencr_toolchain.cmake /project/extras/library_generation/colcon.meta

    find firmware/build/include/ -name "*.c"  -delete
    cp -R firmware/build/include/* /project/src/

    mkdir -p /project/src/cortex-m7/fpv5-sp-d16-softfp
    cp -R firmware/build/libmicroros.a /project/src/cortex-m7/fpv5-sp-d16-softfp/libmicroros.a
fi

######## Build for SAMD (e.g. Arduino Zero) ########
if [[ " ${PLATFORMS[@]} " =~ " cortex_m0 " ]]; then
    rm -rf firmware/build

    export TOOLCHAIN_PREFIX=/uros_ws/gcc-arm-none-eabi-7-2017-q4-major/bin/arm-none-eabi-
    ros2 run micro_ros_setup build_firmware.sh /project/extras/library_generation/cortex_m0_toolchain.cmake /project/extras/library_generation/colcon_verylowmem.meta

    find firmware/build/include/ -name "*.c"  -delete
    cp -R firmware/build/include/* /project/src/

    mkdir -p /project/src/cortex-m0plus
    cp -R firmware/build/libmicroros.a /project/src/cortex-m0plus/libmicroros.a
fi

######## Build for SAM (e.g. Arduino Due) ########
if [[ " ${PLATFORMS[@]} " =~ " cortex_m3 " ]]; then
    rm -rf firmware/build

    export TOOLCHAIN_PREFIX=/uros_ws/gcc-arm-none-eabi-4_8-2014q1/bin/arm-none-eabi-
    ros2 run micro_ros_setup build_firmware.sh /project/extras/library_generation/cortex_m3_toolchain.cmake /project/extras/library_generation/colcon_lowmem.meta

    find firmware/build/include/ -name "*.c"  -delete
    cp -R firmware/build/include/* /project/src/

    mkdir -p /project/src/cortex-m3
    cp -R firmware/build/libmicroros.a /project/src/cortex-m3/libmicroros.a
fi

######## Build for STM32F4 ########
if [[ " ${PLATFORMS[@]} " =~ " cortex_m4 " ]]; then
    rm -rf firmware/build

    export TOOLCHAIN_PREFIX=/uros_ws/gcc-arm-none-eabi-9-2020-q2-update/bin/arm-none-eabi-
    ros2 run micro_ros_setup build_firmware.sh /project/extras/library_generation/cortex_m4_toolchain.cmake /project/extras/library_generation/colcon_lowmem.meta

    find firmware/build/include/ -name "*.c"  -delete
    cp -R firmware/build/include/* /project/src/

    mkdir -p /project/src/cortex-m4
    cp -R firmware/build/libmicroros.a /project/src/cortex-m4/libmicroros.a
fi

######## Build for Teensy 3.2 ########
if [[ " ${PLATFORMS[@]} " =~ " teensy32 " ]]; then
    rm -rf firmware/build

    export TOOLCHAIN_PREFIX=/uros_ws/teensy-compile/tools/arm/bin/arm-none-eabi-
    ros2 run micro_ros_setup build_firmware.sh /project/extras/library_generation/teensy32_toolchain.cmake /project/extras/library_generation/colcon_lowmem.meta

    find firmware/build/include/ -name "*.c"  -delete
    cp -R firmware/build/include/* /project/src/

    mkdir -p /project/src/mk20dx256
    cp -R firmware/build/libmicroros.a /project/src/mk20dx256/libmicroros.a
fi

######## Build for Teensy 3.5 ########
if [[ " ${PLATFORMS[@]} " =~ " teensy35 " ]]; then
    rm -rf firmware/build

    export TOOLCHAIN_PREFIX=/uros_ws/teensy-compile/tools/arm/bin/arm-none-eabi-
    ros2 run micro_ros_setup build_firmware.sh /project/extras/library_generation/teensy35_toolchain.cmake /project/extras/library_generation/colcon_lowmem.meta

    find firmware/build/include/ -name "*.c"  -delete
    cp -R firmware/build/include/* /project/src/

    mkdir -p /project/src/mk64fx512/fpv4-sp-d16-hard
    cp -R firmware/build/libmicroros.a /project/src/mk64fx512/fpv4-sp-d16-hard/libmicroros.a
fi

######## Build for Teensy 3.6 ########
if [[ " ${PLATFORMS[@]} " =~ " teensy36 " ]]; then
    rm -rf firmware/build
    mkdir -p /project/src/mk66fx1m0/fpv4-sp-d16-hard

    # Reuse Teensy 3.5 build if possible
    if [[ " ${PLATFORMS[@]} " =~ " teensy35 " ]]; then
        ln /project/src/mk64fx512/fpv4-sp-d16-hard/libmicroros.a /project/src/mk66fx1m0/fpv4-sp-d16-hard/libmicroros.a
    else
        export TOOLCHAIN_PREFIX=/uros_ws/teensy-compile/tools/arm/bin/arm-none-eabi-
        ros2 run micro_ros_setup build_firmware.sh /project/extras/library_generation/teensy35_toolchain.cmake /project/extras/library_generation/colcon_lowmem.meta

        find firmware/build/include/ -name "*.c"  -delete
        cp -R firmware/build/include/* /project/src/

        cp -R firmware/build/libmicroros.a /project/src/mk66fx1m0/fpv4-sp-d16-hard/libmicroros.a
    fi
fi

######## Build for Teensy 4 ########
if [[ " ${PLATFORMS[@]} " =~ " teensy4 " ]]; then
    rm -rf firmware/build

    export TOOLCHAIN_PREFIX=/uros_ws/teensy-compile/tools/arm/bin/arm-none-eabi-
    ros2 run micro_ros_setup build_firmware.sh /project/extras/library_generation/teensy4_toolchain.cmake /project/extras/library_generation/colcon.meta

    find firmware/build/include/ -name "*.c"  -delete
    cp -R firmware/build/include/* /project/src/

    mkdir -p /project/src/imxrt1062/fpv5-d16-hard
    cp -R firmware/build/libmicroros.a /project/src/imxrt1062/fpv5-d16-hard/libmicroros.a
fi

######## Build for Arduino Portenta M4 core ########
# if [[ " ${PLATFORMS[@]} " =~ " portenta-m4 " ]]; then
#     rm -rf firmware/build

#     export TOOLCHAIN_PREFIX=/uros_ws/gcc-arm-none-eabi-7-2017-q4-major/bin/arm-none-eabi-
#     ros2 run micro_ros_setup build_firmware.sh /project/extras/library_generation/portenta-m4_toolchain.cmake /project/extras/library_generation/colcon.meta

#     find firmware/build/include/ -name "*.c"  -delete
#     cp -R firmware/build/include/* /project/src/

#     mkdir -p /project/src/cortex-m4/fpv4-sp-d16-softfp
#     cp -R firmware/build/libmicroros.a /project/src/cortex-m4/fpv4-sp-d16-softfp/libmicroros.a
# fi

######## Build for Arduino Portenta M7 core ########
if [[ " ${PLATFORMS[@]} " =~ " portenta-m7 " ]]; then
    rm -rf firmware/build

    export TOOLCHAIN_PREFIX=/uros_ws/gcc-arm-none-eabi-7-2017-q4-major/bin/arm-none-eabi-
    ros2 run micro_ros_setup build_firmware.sh /project/extras/library_generation/portenta-m7_toolchain.cmake /project/extras/library_generation/colcon.meta

    find firmware/build/include/ -name "*.c"  -delete
    cp -R firmware/build/include/* /project/src/

    mkdir -p /project/src/cortex-m7/fpv5-d16-softfp
    cp -R firmware/build/libmicroros.a /project/src/cortex-m7/fpv5-d16-softfp/libmicroros.a
fi

######## Build for Kakute F7 M7 core  ########
if [[ " ${PLATFORMS[@]} " =~ " kakutef7-m7 " ]]; then
    rm -rf firmware/build

    export TOOLCHAIN_PREFIX=/uros_ws/gcc-arm-none-eabi-9-2020-q2-update/bin/arm-none-eabi-
    ros2 run micro_ros_setup build_firmware.sh /project/extras/library_generation/kakutef7-m7_toolchain.cmake /project/extras/library_generation/colcon.meta

    find firmware/build/include/ -name "*.c"  -delete
    cp -R firmware/build/include/* /project/src/

    mkdir -p /project/src/cortex-m7/fpv5-sp-d16-hardfp
    cp -R firmware/build/libmicroros.a /project/src/cortex-m7/fpv5-sp-d16-hardfp/libmicroros.a
fi

######## Build for ESP32  ########
if [[ " ${PLATFORMS[@]} " =~ " esp32 " ]]; then
    rm -rf firmware/build

    export TOOLCHAIN_PREFIX=/uros_ws/xtensa-esp32-elf/bin/xtensa-esp32-elf-
    ros2 run micro_ros_setup build_firmware.sh /project/extras/library_generation/esp32_toolchain.cmake /project/extras/library_generation/colcon.meta

    find firmware/build/include/ -name "*.c"  -delete
    cp -R firmware/build/include/* /project/src/

    mkdir -p /project/src/esp32
    cp -R firmware/build/libmicroros.a /project/src/esp32/libmicroros.a
fi

######## Build for ESP32S3  ######
if [[ " ${PLATFORMS[@]} " =~ " esp32s3 " ]]; then
    rm -rf firmware/build

    export TOOLCHAIN_PREFIX=/uros_ws/xtensa-esp32-elf/bin/xtensa-esp32-elf-
    ros2 run micro_ros_setup build_firmware.sh /project/extras/library_generation/esp32_toolchain.cmake /project/extras/library_generation/colcon.meta

    find firmware/build/include/ -name "*.c"  -delete
    cp -R firmware/build/include/* /project/src/

    mkdir -p /project/src/esp32s3
    cp -R firmware/build/libmicroros.a /project/src/esp32s3/libmicroros.a
fi

######## Fix include paths  ########
pushd firmware/mcu_ws > /dev/null
    INCLUDE_ROS2_PACKAGES=$(colcon list | awk '{print $1}' | awk -v d=" " '{s=(NR==1?s:s d)$0}END{print s}')
popd > /dev/null

for var in ${INCLUDE_ROS2_PACKAGES}; do
    cp -R /project/src/${var}/${var}/* /project/src/${var}/ > /dev/null 2>&1
    rm -rf /project/src/${var}/${var}/ > /dev/null 2>&1
done

######## Generate extra files ########
find firmware/mcu_ws/ros2 \( -name "*.srv" -o -name "*.msg" -o -name "*.action" \) | awk -F"/" '{print $(NF-2)"/"$NF}' > /project/available_ros2_types
find firmware/mcu_ws/extra_packages \( -name "*.srv" -o -name "*.msg" -o -name "*.action" \) | awk -F"/" '{print $(NF-2)"/"$NF}' >> /project/available_ros2_types
# sort it so that the result order is reproducible
sort -o /project/available_ros2_types /project/available_ros2_types

cd firmware
echo "" > /project/built_packages
for f in $(find $(pwd) -name .git -type d); do pushd $f > /dev/null; echo $(git config --get remote.origin.url) $(git rev-parse HEAD) >> /project/built_packages; popd > /dev/null; done;
# sort it so that the result order is reproducible
sort -o /project/built_packages /project/built_packages

######## Fix permissions ########
# sudo chmod -R 777 .
