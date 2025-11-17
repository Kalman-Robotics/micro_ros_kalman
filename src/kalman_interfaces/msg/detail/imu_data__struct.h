// generated from rosidl_generator_c/resource/idl__struct.h.em
// with input from kalman_interfaces:msg/ImuData.idl
// generated code does not contain a copyright notice

#ifndef KALMAN_INTERFACES__MSG__DETAIL__IMU_DATA__STRUCT_H_
#define KALMAN_INTERFACES__MSG__DETAIL__IMU_DATA__STRUCT_H_

#ifdef __cplusplus
extern "C"
{
#endif

#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

// Constants defined in the message

/// Struct defined in msg/ImuData in the package kalman_interfaces.
typedef struct kalman_interfaces__msg__ImuData
{
  float accel_x;
  float accel_y;
  float accel_z;
  float gyro_x;
  float gyro_y;
  float gyro_z;
} kalman_interfaces__msg__ImuData;

// Struct for a sequence of kalman_interfaces__msg__ImuData.
typedef struct kalman_interfaces__msg__ImuData__Sequence
{
  kalman_interfaces__msg__ImuData * data;
  /// The number of valid items in data
  size_t size;
  /// The number of allocated items in data
  size_t capacity;
} kalman_interfaces__msg__ImuData__Sequence;

#ifdef __cplusplus
}
#endif

#endif  // KALMAN_INTERFACES__MSG__DETAIL__IMU_DATA__STRUCT_H_
