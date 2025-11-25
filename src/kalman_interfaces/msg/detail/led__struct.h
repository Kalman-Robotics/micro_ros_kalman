// generated from rosidl_generator_c/resource/idl__struct.h.em
// with input from kalman_interfaces:msg/Led.idl
// generated code does not contain a copyright notice

#ifndef KALMAN_INTERFACES__MSG__DETAIL__LED__STRUCT_H_
#define KALMAN_INTERFACES__MSG__DETAIL__LED__STRUCT_H_

#ifdef __cplusplus
extern "C"
{
#endif

#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

// Constants defined in the message

/// Struct defined in msg/Led in the package kalman_interfaces.
/**
  * Led.msg
  * LED interface: on/off plus RGB color (0-255)
  * state: true = ON, false = OFF
 */
typedef struct kalman_interfaces__msg__Led
{
  bool state;
  /// RGB color channels (0-255)
  uint8_t r;
  uint8_t g;
  uint8_t b;
  /// Intensity/brightness (0-255)
  uint8_t intensity;
} kalman_interfaces__msg__Led;

// Struct for a sequence of kalman_interfaces__msg__Led.
typedef struct kalman_interfaces__msg__Led__Sequence
{
  kalman_interfaces__msg__Led * data;
  /// The number of valid items in data
  size_t size;
  /// The number of allocated items in data
  size_t capacity;
} kalman_interfaces__msg__Led__Sequence;

#ifdef __cplusplus
}
#endif

#endif  // KALMAN_INTERFACES__MSG__DETAIL__LED__STRUCT_H_
