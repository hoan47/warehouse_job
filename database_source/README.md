# database_source

## 🧠 Mối Quan Hệ (ERD) tổng thể

Company → Job
Một công ty có thể đăng nhiều công việc (1:N).

City → District
Một thành phố có thể có nhiều quận/huyện (1:N).

Industry ↔ Job (thông qua bảng trung gian JobIndustry)
Một ngành nghề có thể áp dụng cho nhiều công việc và ngược lại (N:M).

JobFunction ↔ Job (thông qua bảng trung gian JobJobFunction)
Một chức năng công việc có thể liên quan tới nhiều công việc và ngược lại (N:M).

GroupJobFunction ↔ Job (thông qua bảng trung gian JobGroupJobFunction)
Một nhóm chức năng công việc có thể liên kết với nhiều công việc và ngược lại (N:M).

Skill ↔ Job (thông qua bảng trung gian JobSkill)
Một kỹ năng có thể yêu cầu cho nhiều công việc và ngược lại (N:M).

BenefitType ↔ Job (thông qua bảng trung gian JobBenefit)
Một phúc lợi có thể áp dụng cho nhiều công việc và một công việc có thể có nhiều phúc lợi (N:M).

Language → Job
Một công việc sử dụng một ngôn ngữ, và một ngôn ngữ có thể liên kết với nhiều công việc (1:N).

Job → WorkingLocation
Một công việc có thể có nhiều địa điểm làm việc khác nhau (1:N).