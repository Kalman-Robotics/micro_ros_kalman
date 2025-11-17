// generated from rosidl_generator_c/resource/idl__struct.h.em
// with input from kalman_interfaces:msg/WifiState.idl
// generated code does not contain a copyright notice

#ifndef KALMAN_INTERFACES__MSG__DETAIL__WIFI_STATE__STRUCT_H_
#define KALMAN_INTERFACES__MSG__DETAIL__WIFI_STATE__STRUCT_H_

#ifdef __cplusplus
extern "C"
{
#endif

#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

// Constants defined in the message

// Include directives for member types
// Member 'stamp'
#include "builtin_interfaces/msg/detail/time__struct.h"

/// Struct defined in msg/WifiState in the package kalman_interfaces.
typedef struct kalman_interfaces__msg__WifiState
{
  builtin_interfaces__msg__Time stamp;
  float rssi_dbm;
} kalman_interfaces__msg__WifiState;

// Struct for a sequence of kalman_interfaces__msg__WifiState.
typedef struct kalman_interfaces__msg__WifiState__Sequence
{
  kalman_interfaces__msg__WifiState * data;
  /// The number of valid items in data
  size_t size;
  /// The number of allocated items in data
  size_t capacity;
} kalman_interfaces__msg__WifiState__Sequence;

#ifdef __cplusplus
}
#endif

#endif  // KALMAN_INTERFACES__MSG__DETAIL__WIFI_STATE__STRUCT_H_
