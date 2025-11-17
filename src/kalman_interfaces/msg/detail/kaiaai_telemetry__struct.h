// generated from rosidl_generator_c/resource/idl__struct.h.em
// with input from kalman_interfaces:msg/KaiaaiTelemetry.idl
// generated code does not contain a copyright notice

#ifndef KALMAN_INTERFACES__MSG__DETAIL__KAIAAI_TELEMETRY__STRUCT_H_
#define KALMAN_INTERFACES__MSG__DETAIL__KAIAAI_TELEMETRY__STRUCT_H_

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
// Member 'joint_pos'
// Member 'joint_vel'
// Member 'lds'
#include "rosidl_runtime_c/primitives_sequence.h"

/// Struct defined in msg/KaiaaiTelemetry in the package kalman_interfaces.
typedef struct kalman_interfaces__msg__KaiaaiTelemetry
{
  builtin_interfaces__msg__Time stamp;
  uint32_t seq;
  float odom_pos_x;
  float odom_pos_y;
  float odom_pos_yaw;
  float odom_vel_x;
  float odom_vel_yaw;
  rosidl_runtime_c__float__Sequence joint_pos;
  rosidl_runtime_c__float__Sequence joint_vel;
  rosidl_runtime_c__uint8__Sequence lds;
} kalman_interfaces__msg__KaiaaiTelemetry;

// Struct for a sequence of kalman_interfaces__msg__KaiaaiTelemetry.
typedef struct kalman_interfaces__msg__KaiaaiTelemetry__Sequence
{
  kalman_interfaces__msg__KaiaaiTelemetry * data;
  /// The number of valid items in data
  size_t size;
  /// The number of allocated items in data
  size_t capacity;
} kalman_interfaces__msg__KaiaaiTelemetry__Sequence;

#ifdef __cplusplus
}
#endif

#endif  // KALMAN_INTERFACES__MSG__DETAIL__KAIAAI_TELEMETRY__STRUCT_H_
