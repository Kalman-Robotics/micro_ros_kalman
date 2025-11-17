// generated from rosidl_generator_c/resource/idl__struct.h.em
// with input from kalman_interfaces:msg/ControlStatus.idl
// generated code does not contain a copyright notice

#ifndef KALMAN_INTERFACES__MSG__DETAIL__CONTROL_STATUS__STRUCT_H_
#define KALMAN_INTERFACES__MSG__DETAIL__CONTROL_STATUS__STRUCT_H_

#ifdef __cplusplus
extern "C"
{
#endif

#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

// Constants defined in the message

// Include directives for member types
// Member 'current_control'
// Member 'current_speed'
// Member 'current_speed_filtered'
// Member 'current_error'
// Member 'setpoint'
#include "kalman_interfaces/msg/detail/motors__struct.h"

/// Struct defined in msg/ControlStatus in the package kalman_interfaces.
typedef struct kalman_interfaces__msg__ControlStatus
{
  kalman_interfaces__msg__Motors current_control;
  kalman_interfaces__msg__Motors current_speed;
  kalman_interfaces__msg__Motors current_speed_filtered;
  kalman_interfaces__msg__Motors current_error;
  kalman_interfaces__msg__Motors setpoint;
} kalman_interfaces__msg__ControlStatus;

// Struct for a sequence of kalman_interfaces__msg__ControlStatus.
typedef struct kalman_interfaces__msg__ControlStatus__Sequence
{
  kalman_interfaces__msg__ControlStatus * data;
  /// The number of valid items in data
  size_t size;
  /// The number of allocated items in data
  size_t capacity;
} kalman_interfaces__msg__ControlStatus__Sequence;

#ifdef __cplusplus
}
#endif

#endif  // KALMAN_INTERFACES__MSG__DETAIL__CONTROL_STATUS__STRUCT_H_
