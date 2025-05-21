# database_source

✅ 4973 rows into Company
✅ 65 rows into City
✅ 49 rows into Industry
✅ 159 rows into JobFunction
✅ 31 rows into GroupJobFunction
✅ 11294 rows into Skill
✅ 15 rows into BenefitType
✅ 7 rows into Language
✅ 14217 rows into Job
✅ 10368 rows into WorkingLocation
✅ 14217 rows into JobIndustry
✅ 68091 rows into JobSkill
✅ 47941 rows into JobBenefit

## 🧠 Mối Quan Hệ (ERD) tổng thể

Company → Job
Một công ty có thể đăng nhiều công việc (1:N).

Industry ↔ Job (thông qua bảng trung gian JobIndustry)
Một ngành nghề có thể áp dụng cho nhiều công việc và ngược lại (N:M).

JobFunction ↔ Job
Một công việc sử dụng một chức năng công việc, và một chức năng công việc có thể liên kết với nhiều công việc (1:N).

GroupJobFunction ↔ Job
Một công việc sử dụng một nhóm chức năng công việc, và một nhóm chức năng công việc có thể liên kết với nhiều công việc (1:N).

Skill ↔ Job (thông qua bảng trung gian JobSkill)
Một kỹ năng có thể yêu cầu cho nhiều công việc và ngược lại (N:M).

BenefitType ↔ Job (thông qua bảng trung gian JobBenefit)
Một phúc lợi có thể áp dụng cho nhiều công việc và một công việc có thể có nhiều phúc lợi (N:M).

Language → Job
Một công việc sử dụng một ngôn ngữ, và một ngôn ngữ có thể liên kết với nhiều công việc (1:N).

Job → WorkingLocation
Một công việc có thể có nhiều địa điểm làm việc khác nhau (1:N).