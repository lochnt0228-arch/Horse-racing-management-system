# 🤝 Contributing Guidelines

## Git Workflow
Chúng ta sử dụng **Feature Branch Workflow** với 2 branch chính:
- `main` - Production-ready code (chỉ merge từ develop)
- `develop` - Integration branch (tất cả features merge vào đây)

### Quy trình làm việc
```
1. git checkout develop
2. git pull origin develop
3. git checkout -b feature/<tên-feature>
4. ... code ...
5. git add . && git commit -m "feat(module): mô tả"
6. git push origin feature/<tên-feature>
7. Tạo Pull Request trên GitHub → develop
8. Code review bởi nhóm trưởng
9. Merge sau khi approved
```

### Branch Naming Convention
| Loại | Format | Ví dụ |
|------|--------|-------|
| Feature BE | `feature/be-<module>-<task>` | `feature/be-auth-jwt-setup` |
| Feature FE | `feature/fe-<page>` | `feature/fe-login-page` |
| Bugfix | `bugfix/<mô-tả>` | `bugfix/login-validation-error` |
| Hotfix | `hotfix/<mô-tả>` | `hotfix/jwt-token-expired` |
| Docs | `docs/<mô-tả>` | `docs/api-specification` |

### Commit Message Convention (Conventional Commits)
```
<type>(<scope>): <description>

Types:
  feat     - Tính năng mới
  fix      - Sửa bug
  docs     - Thay đổi documentation
  style    - Format code (không ảnh hưởng logic)
  refactor - Refactor code
  test     - Thêm/sửa tests
  chore    - Cập nhật build, dependencies

Scopes:
  auth, horse, jockey, owner, tournament, race,
  registration, bet, result, prize, report,
  frontend, config, db
```

## Coding Standards
### Java (Spring Boot)
- Package naming: `com.horseracing.<layer>` (model, repository, service, controller, dto, config, security, exception, util)
- Class naming: PascalCase (e.g., `HorseOwnerService`)
- Method naming: camelCase (e.g., `findByOwnerId`)
- Sử dụng Lombok annotations (`@Data`, `@Builder`, `@NoArgsConstructor`, `@AllArgsConstructor`)
- Sử dụng DTOs cho request/response (KHÔNG trả entity trực tiếp)
- Global Exception handling: xử lý tại `@ControllerAdvice`

### React / Next.js
- Component naming: PascalCase (e.g., `HorseCard.tsx`)
- File naming: kebab-case cho pages, PascalCase cho components
- Sử dụng TypeScript
