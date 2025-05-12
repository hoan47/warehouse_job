USE master;
DROP DATABASE job;
CREATE DATABASE job;					 -- Database Source (work)
GO

USE job;

CREATE TABLE Company (
    CompanyId INT PRIMARY KEY,           -- Mã định danh duy nhất cho công ty
    CompanyName NVARCHAR(255),           -- Tên công ty (ví dụ: "Ngân Hàng TMCP Phát Triển TP.HCM")
    CompanyLogo NVARCHAR(500),           -- Đường dẫn hoặc URL đến logo công ty (ví dụ: "https://logo.com/company.png")
    Address NVARCHAR(500)                -- Địa chỉ chính của công ty (ví dụ: "Tầng 20, CEO Tower, Hà Nội")
);
-- Ý nghĩa:
-- CompanyId: Khóa chính, nhận diện công ty duy nhất, liên kết với Job để chỉ định công ty đăng tuyển (ví dụ: CompanyId: 330753).
-- CompanyName: Tên công ty, hiển thị trong danh sách công việc hoặc hồ sơ công ty.
-- CompanyLogo: Đường dẫn đến logo, dùng để hiển thị trên giao diện.
-- Address: Địa chỉ trụ sở chính hoặc đại diện của công ty, giới hạn một địa chỉ mỗi công ty.


CREATE TABLE City (
    CityId INT PRIMARY KEY,             -- Mã định danh duy nhất cho thành phố
    CityNameVI NVARCHAR(100),           -- Tên thành phố bằng tiếng Việt (ví dụ: "Hà Nội")
    CityName NVARCHAR(100)              -- Tên thành phố bằng tiếng Anh (ví dụ: "Hanoi")
);
-- Ý nghĩa:
-- CityId: Khóa chính, nhận diện thành phố duy nhất, liên kết với WorkingLocation (ví dụ: CityId: 24 cho Hà Nội).
-- CityNameVI: Tên thành phố bằng tiếng Việt, dùng cho giao diện tiếng Việt.
-- CityName: Tên thành phố bằng tiếng Anh, dùng cho giao diện quốc tế.


CREATE TABLE Industry (
    IndustryId INT PRIMARY KEY,         -- Mã định danh duy nhất cho ngành nghề
    IndustryName NVARCHAR(255),         -- Tên ngành nghề bằng tiếng Anh (ví dụ: "Banking")
    IndustryNameVI NVARCHAR(255)        -- Tên ngành nghề bằng tiếng Việt (ví dụ: "Ngân hàng")
);
-- Ý nghĩa:
-- IndustryId: Khóa chính, nhận diện ngành nghề duy nhất, liên kết với JobIndustry (ví dụ: IndustryId: 5 cho "Banking").
-- IndustryName: Tên ngành bằng tiếng Anh, dùng cho giao diện quốc tế.
-- IndustryNameVI: Tên ngành bằng tiếng Việt, dùng cho giao diện địa phương.


CREATE TABLE JobFunction (
    JobFunctionId INT PRIMARY KEY,      -- Mã định danh duy nhất cho chức năng công việc
    JobFunctionName NVARCHAR(255),      -- Tên chức năng công việc bằng tiếng Anh (ví dụ: "Customer Service")
    JobFunctionNameVI NVARCHAR(255)     -- Tên chức năng công việc bằng tiếng Việt (ví dụ: "Dịch vụ khách hàng")
);
-- Ý nghĩa:
-- JobFunctionId: Khóa chính, nhận diện chức năng công việc chi tiết (ví dụ: JobFunctionId: 101 cho "Customer Service").
-- JobFunctionName: Tên chức năng bằng tiếng Anh, mô tả vai trò cụ thể của công việc.
-- JobFunctionNameVI: Tên chức năng bằng tiếng Việt, dùng cho giao diện địa phương.


CREATE TABLE GroupJobFunction (
    GroupJobFunctionId INT PRIMARY KEY, -- Mã định danh duy nhất cho nhóm chức năng công việc
    GroupJobFunctionName NVARCHAR(255), -- Tên nhóm chức năng bằng tiếng Anh (ví dụ: "Banking & Financial Services")
    GroupJobFunctionNameVI NVARCHAR(255)-- Tên nhóm chức năng bằng tiếng Việt (ví dụ: "Ngân hàng & Dịch vụ tài chính")
);
-- Ý nghĩa:
-- GroupJobFunctionId: Khóa chính, nhận diện nhóm chức năng lớn (ví dụ: GroupJobFunctionId: 10).
-- GroupJobFunctionName: Tên nhóm bằng tiếng Anh, phân loại công việc theo danh mục lớn.
-- GroupJobFunctionNameVI: Tên nhóm bằng tiếng Việt, dùng cho giao diện địa phương.


CREATE TABLE Skill (
    SkillId INT PRIMARY KEY,            -- Mã định danh duy nhất cho kỹ năng
    SkillName NVARCHAR(255)             -- Tên kỹ năng (ví dụ: "Tìm Kiếm Khách Hàng")
);
-- Ý nghĩa:
-- SkillId: Khóa chính, nhận diện kỹ năng duy nhất, liên kết với JobSkill.
-- SkillName: Tên kỹ năng, mô tả yêu cầu kỹ năng cho công việc (ví dụ: "Quan Hệ Khách Hàng").


CREATE TABLE BenefitType (
    BenefitId INT PRIMARY KEY,          -- Mã định danh duy nhất cho loại lợi ích
    BenefitName NVARCHAR(255),          -- Tên lợi ích bằng tiếng Anh (ví dụ: "Bonus")
    BenefitNameVI NVARCHAR(255),        -- Tên lợi ích bằng tiếng Việt (ví dụ: "Thưởng")
    BenefitIconName NVARCHAR(100)       -- Tên biểu tượng cho lợi ích (ví dụ: "fa-dollar")
);
-- Ý nghĩa:
-- BenefitId: Khóa chính, nhận diện loại lợi ích duy nhất, liên kết với JobBenefit (ví dụ: BenefitId: 1).
-- BenefitName: Tên lợi ích bằng tiếng Anh.
-- BenefitNameVI: Tên lợi ích bằng tiếng Việt.
-- BenefitIconName: Tên biểu tượng (CSS class), dùng để hiển thị trực quan.


CREATE TABLE Language (
    LanguageId INT PRIMARY KEY,         -- Mã định danh duy nhất cho ngôn ngữ
    LanguageName NVARCHAR(100),         -- Tên ngôn ngữ bằng tiếng Anh (ví dụ: "English")
    LanguageNameVI NVARCHAR(100)        -- Tên ngôn ngữ bằng tiếng Việt (ví dụ: "Tiếng Anh")
);
-- Ý nghĩa:
-- LanguageId: Khóa chính, nhận diện ngôn ngữ duy nhất, liên kết với Job.
-- LanguageName: Tên ngôn ngữ bằng tiếng Anh.
-- LanguageNameVI: Tên ngôn ngữ bằng tiếng Việt.


CREATE TABLE Job (
    JobId INT PRIMARY KEY,              -- Mã định danh duy nhất cho công việc
    JobTitle NVARCHAR(255),             -- Tiêu đề công việc (ví dụ: "Nhân Viên Quan Hệ Khách Hàng")
    JobUrl NVARCHAR(500),               -- URL của công việc trên website
    CompanyId INT FOREIGN KEY REFERENCES Company(CompanyId), -- Mã công ty đăng tuyển
    SalaryMin INT,                      -- Mức lương tối thiểu
    SalaryMax INT,                      -- Mức lương tối đa
    SalaryCurrency NVARCHAR(10),        -- Đơn vị tiền tệ của lương (ví dụ: "VND")
    JobLevel NVARCHAR(100),             -- Cấp bậc công việc (ví dụ: "Nhân viên")
    TypeWorkingId INT,                  -- Mã loại hình làm việc (ví dụ: 1 = Toàn thời gian)
    ApprovedOn DATETIME,                -- Ngày duyệt công việc
    OnlineOn DATETIME,                  -- Ngày công việc được đăng online
    ExpiredOn DATETIME,                 -- Ngày công việc hết hạn
    IsUrgentJob BIT,                    -- Cờ công việc khẩn cấp (1 = Có, 0 = Không)
    IsTopPriority BIT,                  -- Cờ công việc ưu tiên hàng đầu
    IsMobileHotJob BIT,                 -- Cờ công việc nổi bật trên di động
    JobDescription NVARCHAR(MAX),       -- Mô tả công việc
    JobRequirement NVARCHAR(MAX),       -- Yêu cầu công việc
    LanguageId INT FOREIGN KEY REFERENCES Language(LanguageId) -- Mã ngôn ngữ yêu cầu
);
-- Ý nghĩa:
-- JobId: Khóa chính, nhận diện công việc duy nhất (ví dụ: JobId: 1899671).
-- JobTitle: Tiêu đề công việc, hiển thị trong danh sách tuyển dụng.
-- JobUrl: Đường dẫn đến trang chi tiết công việc.
-- CompanyId: Liên kết với công ty đăng tuyển.
-- SalaryMin, SalaryMax, SalaryCurrency: Phạm vi lương và đơn vị tiền tệ.
-- JobLevel: Cấp bậc công việc, hỗ trợ lọc.
-- TypeWorkingId: Loại hình làm việc (toàn thời gian, từ xa, v.v.).
-- ApprovedOn, OnlineOn, ExpiredOn: Quản lý trạng thái công việc.
-- IsUrgentJob, IsTopPriority, IsMobileHotJob: Ưu tiên hiển thị.
-- JobDescription, JobRequirement: Thông tin chi tiết cho ứng viên.
-- LanguageId: Ngôn ngữ yêu cầu (ví dụ: "Any").


CREATE TABLE WorkingLocation (
    WorkingLocationId INT PRIMARY KEY,  -- Mã định danh duy nhất cho địa điểm làm việc
    JobId INT FOREIGN KEY REFERENCES Job(JobId), -- Mã công việc liên kết
    Address NVARCHAR(500),              -- Địa chỉ cụ thể của địa điểm
	CityId INT FOREIGN KEY REFERENCES City(CityId),
    Latitude FLOAT,                     -- Vĩ độ của địa điểm
    Longitude FLOAT                     -- Kinh độ của địa điểm
);
-- Ý nghĩa:
-- WorkingLocationId: Khóa chính, nhận diện địa điểm làm việc (ví dụ: WorkingLocationId: 142841).
-- JobId: Liên kết với công việc, hỗ trợ nhiều địa điểm cho một Job.
-- Address: Địa chỉ chi tiết (ví dụ: "Tầng 20, CEO Tower, Hà Nội").
-- CityId: Mã thành phố (ví dụ: CityId: 24).
-- Latitude, Longitude: Tọa độ địa lý, hỗ trợ bản đồ.


CREATE TABLE JobIndustry (
    JobId INT,                          -- Mã công việc
    IndustryId INT,                     -- Mã ngành nghề
    PRIMARY KEY (JobId, IndustryId),
    FOREIGN KEY (JobId) REFERENCES Job(JobId),
    FOREIGN KEY (IndustryId) REFERENCES Industry(IndustryId)
);
-- Ý nghĩa:
-- JobId, IndustryId: Khóa chính composite, liên kết Job với nhiều ngành nghề (N-N).


CREATE TABLE JobJobFunction (
    JobId INT,                          -- Mã công việc
    JobFunctionId INT,                  -- Mã chức năng công việc
    PRIMARY KEY (JobId, JobFunctionId),
    FOREIGN KEY (JobId) REFERENCES Job(JobId),
    FOREIGN KEY (JobFunctionId) REFERENCES JobFunction(JobFunctionId)
);
-- Ý nghĩa:
-- JobId, JobFunctionId: Khóa chính composite, liên kết Job với nhiều chức năng chi tiết (N-N, ví dụ: "Customer Service", "Relationship Management").


CREATE TABLE JobGroupJobFunction (
    JobId INT,                          -- Mã công việc
    GroupJobFunctionId INT,             -- Mã nhóm chức năng
    PRIMARY KEY (JobId, GroupJobFunctionId),
    FOREIGN KEY (JobId) REFERENCES Job(JobId),
    FOREIGN KEY (GroupJobFunctionId) REFERENCES GroupJobFunction(GroupJobFunctionId)
);
-- Ý nghĩa:
-- JobId, GroupJobFunctionId: Khóa chính composite, liên kết Job với nhiều nhóm chức năng (N-N, ví dụ: "Banking & Financial Services").


CREATE TABLE JobSkill (
    JobId INT FOREIGN KEY REFERENCES Job(JobId), -- Mã công việc
    SkillId INT FOREIGN KEY REFERENCES Skill(SkillId), -- Mã kỹ năng
    PRIMARY KEY (JobId, SkillId)
);
-- Ý nghĩa:
-- JobId, SkillId: Khóa chính composite, liên kết Job với nhiều kỹ năng (N-N).


CREATE TABLE JobBenefit (
    JobId INT FOREIGN KEY REFERENCES Job(JobId), -- Mã công việc
    BenefitId INT FOREIGN KEY REFERENCES BenefitType(BenefitId), -- Mã loại lợi ích
    BenefitValue NVARCHAR(500),         -- Giá trị cụ thể của lợi ích
    PRIMARY KEY (JobId, BenefitId)
);
-- Ý nghĩa:
-- JobId, BenefitId: Khóa chính composite, liên kết Job với nhiều lợi ích (N-N).
-- BenefitValue: Giá trị cụ thể (ví dụ: "Lương tháng 13").

