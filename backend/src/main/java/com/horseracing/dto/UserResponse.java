package com.horseracing.dto;

import com.horseracing.model.enums.Role;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class UserResponse {

    private Long id;
    private String username;
    private String email;
    private String fullName;
    private String phone;
    private String address;
    private Role role;
    private String licenseNumber;
    private Integer experienceYears;
    private BigDecimal weight;
    private boolean isActive;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}