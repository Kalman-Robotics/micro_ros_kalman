// generated from rosidl_generator_c/resource/idl__struct.h.em
// with input from kalman_interfaces:msg/Buzzer.idl
// generated code does not contain a copyright notice

#ifndef KALMAN_INTERFACES__MSG__DETAIL__BUZZER__STRUCT_H_
#define KALMAN_INTERFACES__MSG__DETAIL__BUZZER__STRUCT_H_

#ifdef __cplusplus
extern "C"
{
#endif

#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

// Constants defined in the message

/// Struct defined in msg/Buzzer in the package kalman_interfaces.
/**
  * Buzzer.msg
  * Buzzer interface: on/off plus frequency in Hz
  * state: true = ON, false = OFF
 */
typedef struct kalman_interfaces__msg__Buzzer
{
  bool state;
  /// Frequency in Hertz (uint16_t)
  uint16_t frequency;
} kalman_interfaces__msg__Buzzer;

// Struct for a sequence of kalman_interfaces__msg__Buzzer.
typedef struct kalman_interfaces__msg__Buzzer__Sequence
{
  kalman_interfaces__msg__Buzzer * data;
  /// The number of valid items in data
  size_t size;
  /// The number of allocated items in data
  size_t capacity;
} kalman_interfaces__msg__Buzzer__Sequence;

#ifdef __cplusplus
}
#endif

#endif  // KALMAN_INTERFACES__MSG__DETAIL__BUZZER__STRUCT_H_
