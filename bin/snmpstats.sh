#!/bin/bash

DATE=$(date +%s)

SATURN_CPU_USR=$(snmpget saturn.local -v1 -cpublic .1.3.6.1.4.1.2021.11.50.0 -Ov | cut -f2 -d' ')
SATURN_CPU_NIC=$(snmpget saturn.local -v1 -cpublic .1.3.6.1.4.1.2021.11.51.0 -Ov | cut -f2 -d' ')
SATURN_CPU_SYS=$(snmpget saturn.local -v1 -cpublic .1.3.6.1.4.1.2021.11.52.0 -Ov | cut -f2 -d' ')
SATURN_CPU_IDL=$(snmpget saturn.local -v1 -cpublic .1.3.6.1.4.1.2021.11.53.0 -Ov | cut -f2 -d' ')
SATURN_CPU_IOW=$(snmpget saturn.local -v1 -cpublic .1.3.6.1.4.1.2021.11.54.0 -Ov | cut -f2 -d' ')
SATURN_CPU_KRN=$(snmpget saturn.local -v1 -cpublic .1.3.6.1.4.1.2021.11.55.0 -Ov | cut -f2 -d' ')
SATURN_CPU_INT=$(snmpget saturn.local -v1 -cpublic .1.3.6.1.4.1.2021.11.56.0 -Ov | cut -f2 -d' ')

SATURN_RAM=$(snmpget saturn.local -v1 -cpublic HOST-RESOURCES-MIB::hrStorageUsed.2 -Ov | cut -f2 -d' ')
SATURN_SWAP=$(snmpget saturn.local -v1 -cpublic HOST-RESOURCES-MIB::hrStorageUsed.3 -Ov | cut -f2 -d' ')

NEPTUNE_CPU_USR=$(snmpget neptune.local -v1 -cpublic .1.3.6.1.4.1.2021.11.50.0 -Ov | cut -f2 -d' ')
NEPTUNE_CPU_NIC=$(snmpget neptune.local -v1 -cpublic .1.3.6.1.4.1.2021.11.51.0 -Ov | cut -f2 -d' ')
NEPTUNE_CPU_SYS=$(snmpget neptune.local -v1 -cpublic .1.3.6.1.4.1.2021.11.52.0 -Ov | cut -f2 -d' ')
NEPTUNE_CPU_IDL=$(snmpget neptune.local -v1 -cpublic .1.3.6.1.4.1.2021.11.53.0 -Ov | cut -f2 -d' ')
NEPTUNE_CPU_IOW=$(snmpget neptune.local -v1 -cpublic .1.3.6.1.4.1.2021.11.54.0 -Ov | cut -f2 -d' ')
NEPTUNE_CPU_KRN=$(snmpget neptune.local -v1 -cpublic .1.3.6.1.4.1.2021.11.55.0 -Ov | cut -f2 -d' ')
NEPTUNE_CPU_INT=$(snmpget neptune.local -v1 -cpublic .1.3.6.1.4.1.2021.11.56.0 -Ov | cut -f2 -d' ')

NEPTUNE_RAM=$(snmpget neptune.local -v1 -cpublic HOST-RESOURCES-MIB::hrStorageUsed.1 -Ov | cut -f2 -d' ')
NEPTUNE_SWAP=$(snmpget neptune.local -v1 -cpublic HOST-RESOURCES-MIB::hrStorageUsed.10 -Ov | cut -f2 -d' ')

BYTES_IN=$(snmpget router -v1 -cpublic IF-MIB::ifInOctets.6 -Ov | cut -f2 -d' ')
BYTES_OUT=$(snmpget router -v1 -cpublic IF-MIB::ifOutOctets.6 -Ov | cut -f2 -d' ')

XBMC_CPU_USR=$(snmpget xbmc.local -v1 -cpublic .1.3.6.1.4.1.2021.11.50.0 -Ov | cut -f2 -d' ')
XBMC_CPU_NIC=$(snmpget xbmc.local -v1 -cpublic .1.3.6.1.4.1.2021.11.51.0 -Ov | cut -f2 -d' ')
XBMC_CPU_SYS=$(snmpget xbmc.local -v1 -cpublic .1.3.6.1.4.1.2021.11.52.0 -Ov | cut -f2 -d' ')
XBMC_CPU_IDL=$(snmpget xbmc.local -v1 -cpublic .1.3.6.1.4.1.2021.11.53.0 -Ov | cut -f2 -d' ')
XBMC_CPU_IOW=$(snmpget xbmc.local -v1 -cpublic .1.3.6.1.4.1.2021.11.54.0 -Ov | cut -f2 -d' ')
XBMC_CPU_KRN=$(snmpget xbmc.local -v1 -cpublic .1.3.6.1.4.1.2021.11.55.0 -Ov | cut -f2 -d' ')
XBMC_CPU_INT=$(snmpget xbmc.local -v1 -cpublic .1.3.6.1.4.1.2021.11.56.0 -Ov | cut -f2 -d' ')

XBMC_RAM=$(snmpget xbmc.local -v1 -cpublic HOST-RESOURCES-MIB::hrStorageUsed.1 -Ov | cut -f2 -d' ')

(
    echo "com.suborbit.home.saturn.CPU_user ${SATURN_CPU_USR} ${DATE}"
    echo "com.suborbit.home.saturn.CPU_nice ${SATURN_CPU_NIC} ${DATE}"
    echo "com.suborbit.home.saturn.CPU_system ${SATURN_CPU_SYS} ${DATE}"
    echo "com.suborbit.home.saturn.CPU_idle ${SATURN_CPU_IDL} ${DATE}"
    echo "com.suborbit.home.saturn.CPU_iowait ${SATURN_CPU_IOW} ${DATE}"
    echo "com.suborbit.home.saturn.CPU_kernel ${SATURN_CPU_KRN} ${DATE}"
    echo "com.suborbit.home.saturn.CPU_int ${SATURN_CPU_INT} ${DATE}"

    echo "com.suborbit.home.saturn.Used_Memory ${SATURN_RAM} ${DATE}"
    echo "com.suborbit.home.saturn.Used_Swap ${SATURN_SWAP} ${DATE}"

    echo "com.suborbit.home.neptune.CPU_user ${NEPTUNE_CPU_USR} ${DATE}"
    echo "com.suborbit.home.neptune.CPU_nice ${NEPTUNE_CPU_NIC} ${DATE}"
    echo "com.suborbit.home.neptune.CPU_system ${NEPTUNE_CPU_SYS} ${DATE}"
    echo "com.suborbit.home.neptune.CPU_idle ${NEPTUNE_CPU_IDL} ${DATE}"
    echo "com.suborbit.home.neptune.CPU_iowait ${NEPTUNE_CPU_IOW} ${DATE}"
    echo "com.suborbit.home.neptune.CPU_kernel ${NEPTUNE_CPU_KRN} ${DATE}"
    echo "com.suborbit.home.neptune.CPU_int ${NEPTUNE_CPU_INT} ${DATE}"

    echo "com.suborbit.home.neptune.Used_Memory ${NEPTUNE_RAM} ${DATE}"
    echo "com.suborbit.home.neptune.Used_Swap ${NEPTUNE_SWAP} ${DATE}"

    echo "com.suborbit.home.broadband.BYTES_down ${BYTES_IN} ${DATE}"
    echo "com.suborbit.home.broadband.BYTES_up ${BYTES_OUT} ${DATE}"

    echo "com.suborbit.home.xbmc.CPU_user ${XBMC_CPU_USR} ${DATE}"
    echo "com.suborbit.home.xbmc.CPU_nice ${XBMC_CPU_NIC} ${DATE}"
    echo "com.suborbit.home.xbmc.CPU_system ${XBMC_CPU_SYS} ${DATE}"
    echo "com.suborbit.home.xbmc.CPU_idle ${XBMC_CPU_IDL} ${DATE}"
    echo "com.suborbit.home.xbmc.CPU_iowait ${XBMC_CPU_IOW} ${DATE}"
    echo "com.suborbit.home.xbmc.CPU_kernel ${XBMC_CPU_KRN} ${DATE}"
    echo "com.suborbit.home.xbmc.CPU_int ${XBMC_CPU_INT} ${DATE}"

    echo "com.suborbit.home.xbmc.Used_Memory ${XBMC_RAM} ${DATE}"
)  | nc neptune.local 2003
