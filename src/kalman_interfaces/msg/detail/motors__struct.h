// generated from rosidl_generator_c/resource/idl__struct.h.em
// with input from kalman_interfaces:msg/Motors.idl
// generated code does not contain a copyright notice

#ifndef KALMAN_INTERFACES__MSG__DETAIL__MOTORS__STRUCT_H_
#define KALMAN_INTERFACES__MSG__DETAIL__MOTORS__STRUCT_H_

#ifdef __cplusplus
extern "C"
{
#endif

#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

// Constants defined in the message

/// Struct defined in msg/Motors in the package kalman_interfaces.
typedef struct kalman_interfaces__msg__Motors
{
  float motor_l;
  float motor_r;
} kalman_interfaces__msg__Motors;

// Struct for a sequence of kalman_interfaces__msg__Motors.
typedef struct kalman_interfaces__msg__Motors__Sequence
{
  kalman_interfaces__msg__Motors * data;
  /// The number of valid items in data
  size_t size;
  /// The number of allocated items in data
  size_t capacity;
} kalman_interfaces__msg__Motors__Sequence;

#ifdef __cplusplus
}
#endif

#endif  // KALMAN_INTERFACES__MSG__DETAIL__MOTORS__STRUCT_H_
