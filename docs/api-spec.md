# 📡 API Specification

## Base URL
```
http://localhost:8080/api
```

## Authentication
Sử dụng JWT Bearer Token trong header:
```
Authorization: Bearer <jwt-token>
```

## 🔐 Auth APIs (TV1)
- `POST /auth/register` - Đăng ký tài khoản
- `POST /auth/login` - Đăng nhập
- `POST /auth/refresh-token` - Refresh JWT
- `GET /auth/me` - Lấy thông tin user hiện tại

## 🐴 Horse APIs (TV2)
- `GET /horses` - Danh sách ngựa (paginated, filter)
- `GET /horses/{id}` - Chi tiết ngựa
- `POST /horses` - Tạo ngựa mới
- `PUT /horses/{id}` - Cập nhật ngựa
- `DELETE /horses/{id}` - Xóa ngựa

## 🏆 Tournament APIs (TV3)
- `GET /tournaments` - Danh sách giải đấu
- `GET /tournaments/{id}` - Chi tiết giải đấu
- `POST /tournaments` - Tạo giải đấu (ADMIN)
- `PUT /tournaments/{id}` - Cập nhật giải đấu (ADMIN)

## 💰 Bet APIs (TV4)
- `POST /bets` - Đặt cược
- `GET /bets/my` - Lịch sử cược cá nhân
- `GET /bets/race/{raceId}/odds` - Tỷ lệ cược cuộc đua
