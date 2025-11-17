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

/// Struct defined in msg/ControlStatus in the package kalman_interfaces.
typedef struct kalman_interfaces__msg__ControlStatus
{
  float r_current_control;
  float r_current_speed;
  float r_current_speed_filtered;
  float r_current_error;
  float r_setpoint;
  float l_current_control;
  float l_current_speed;
  float l_current_speed_filtered;
  float l_current_error;
  float l_setpoint;
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
