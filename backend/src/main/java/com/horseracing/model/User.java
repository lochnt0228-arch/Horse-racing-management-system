package com.horseracing.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.horseracing.model.base.BaseEntity;
import com.horseracing.model.enums.Role;
import jakarta.persistence.*;
import lombok.*;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.math.BigDecimal;
import java.util.Collection;
import java.util.List;

@Entity
@Table(name = "users")
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class User extends BaseEntity implements UserDetails {

    @Column(nullable = false, unique = true, length = 50)
    private String username;

    @Column(nullable = false, unique = true, length = 100)
    private String email;

    @JsonIgnore
    @Column(nullable = false, length = 255)
    private String password;

    @Column(name = "full_name", nullable = false, length = 100)
    private String fullName;

    @Column(length = 20)
    private String phone;

    @Column(length = 255)
    private String address;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    @Builder.Default
    private Role role = Role.SPECTATOR;

    @Column(name = "license_number", length = 50)
    private String licenseNumber;

    @Column(name = "experience_years")
    private Integer experienceYears;

    @Column(precision = 5, scale = 2)
    private BigDecimal weight;

    @Column(name = "is_active", nullable = false)
    @Builder.Default
    private boolean isActive = true;

    // --- CẤU HÌNH PHÂN QUYỀN SPRING SECURITY (USERDETAILS) ---

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        // Chuyển đổi enum Role thành SimpleGrantedAuthority dạng "ROLE_ADMIN", "ROLE_SPECTATOR",...
        return List.of(new SimpleGrantedAuthority("ROLE_" + role.name()));
    }

    @Override
    public boolean isAccountNonExpired() {
        return true; // Tài khoản không bao giờ hết hạn
    }

    @Override
    public boolean isAccountNonLocked() {
        return true; // Tài khoản không bị khóa
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true; // Thông tin xác thực không hết hạn
    }

    @Override
    public boolean isEnabled() {
        return this.isActive; // Trạng thái hoạt động dựa trên trường isActive
    }
}