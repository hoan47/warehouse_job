USE job;
GO

-- Xóa dữ liệu trong các bảng stage trước khi load
TRUNCATE TABLE jobDWStage.dbo.CompanyStage;
TRUNCATE TABLE jobDWStage.dbo.CityStage;
TRUNCATE TABLE jobDWStage.dbo.IndustryStage;
TRUNCATE TABLE jobDWStage.dbo.JobFunctionStage;
TRUNCATE TABLE jobDWStage.dbo.GroupJobFunctionStage;
TRUNCATE TABLE jobDWStage.dbo.SkillStage;
TRUNCATE TABLE jobDWStage.dbo.BenefitTypeStage;
TRUNCATE TABLE jobDWStage.dbo.LanguageStage;
TRUNCATE TABLE jobDWStage.dbo.JobStage;
TRUNCATE TABLE jobDWStage.dbo.WorkingLocationStage;
TRUNCATE TABLE jobDWStage.dbo.JobIndustryStage;
TRUNCATE TABLE jobDWStage.dbo.JobSkillStage;
TRUNCATE TABLE jobDWStage.dbo.JobBenefitStage;

-- 1. ETL cho bảng CompanyStage
INSERT INTO jobDWStage.dbo.CompanyStage (CompanyId, CompanyName, CompanyLogo, Address)
SELECT 
    CompanyId,
    CompanyName,
    CompanyLogo,
    Address
FROM job.dbo.Company;

-- 2. ETL cho bảng CityStage
INSERT INTO jobDWStage.dbo.CityStage (CityId, CityName, CityNameVI)
SELECT 
    CityId,
    CityName,
    CityNameVI
FROM job.dbo.City;

-- 3. ETL cho bảng IndustryStage
INSERT INTO jobDWStage.dbo.IndustryStage (IndustryId, IndustryName, IndustryNameVI)
SELECT 
    IndustryId,
    IndustryName,
    IndustryNameVI
FROM job.dbo.Industry;

-- 4. ETL cho bảng JobFunctionStage
INSERT INTO jobDWStage.dbo.JobFunctionStage (JobFunctionId, JobFunctionName, JobFunctionNameVI)
SELECT 
    JobFunctionId,
    JobFunctionName,
    JobFunctionNameVI
FROM job.dbo.JobFunction;

-- 5. ETL cho bảng GroupJobFunctionStage
INSERT INTO jobDWStage.dbo.GroupJobFunctionStage (GroupJobFunctionId, GroupJobFunctionName, GroupJobFunctionNameVI)
SELECT 
    GroupJobFunctionId,
    GroupJobFunctionName,
    GroupJobFunctionNameVI
FROM job.dbo.GroupJobFunction;

-- 6. ETL cho bảng SkillStage
INSERT INTO jobDWStage.dbo.SkillStage (SkillId, SkillName)
SELECT 
    SkillId,
    SkillName
FROM job.dbo.Skill;

-- 7. ETL cho bảng BenefitTypeStage
INSERT INTO jobDWStage.dbo.BenefitTypeStage (BenefitId, BenefitName, BenefitNameVI, BenefitIconName)
SELECT 
    BenefitId,
    BenefitName,
    BenefitNameVI,
    BenefitIconName
FROM job.dbo.BenefitType;

-- 8. ETL cho bảng LanguageStage
INSERT INTO jobDWStage.dbo.LanguageStage (LanguageId, LanguageName, LanguageNameVI)
SELECT 
    LanguageId,
    LanguageName,
    LanguageNameVI
FROM job.dbo.Language;

-- 9. ETL cho bảng JobStage
INSERT INTO jobDWStage.dbo.JobStage (
    JobId, JobTitle, JobUrl, CompanyId, SalaryMin, SalaryMax, SalaryCurrency, 
    JobLevel, TypeWorkingId, ApprovedOn, OnlineOn, ExpiredOn, IsUrgentJob, 
    IsTopPriority, IsMobileHotJob, JobDescription, JobRequirement, LanguageId, 
    JobFunctionId, GroupJobFunctionId
)
SELECT 
    JobId,
    JobTitle,
    JobUrl,
    CompanyId,
    SalaryMin,
    SalaryMax,
    SalaryCurrency,
    JobLevel,
    TypeWorkingId,
    ApprovedOn,
    OnlineOn,
    ExpiredOn,
    IsUrgentJob,
    IsTopPriority,
    IsMobileHotJob,
    JobDescription,
    JobRequirement,
    LanguageId,
    JobFunctionId,
    GroupJobFunctionId
FROM job.dbo.Job;

-- 10. ETL cho bảng WorkingLocationStage
INSERT INTO jobDWStage.dbo.WorkingLocationStage (WorkingLocationId, JobId, Address, CityId, Latitude, Longitude)
SELECT 
    WorkingLocationId,
    JobId,
    Address,
    CityId,
    Latitude,
    Longitude
FROM job.dbo.WorkingLocation;

-- 11. ETL cho bảng JobIndustryStage
INSERT INTO jobDWStage.dbo.JobIndustryStage (JobId, IndustryId)
SELECT 
    JobId,
    IndustryId
FROM job.dbo.JobIndustry;

-- 12. ETL cho bảng JobSkillStage
INSERT INTO jobDWStage.dbo.JobSkillStage (JobId, SkillId)
SELECT 
    JobId,
    SkillId
FROM job.dbo.JobSkill;

-- 13. ETL cho bảng JobBenefitStage
INSERT INTO jobDWStage.dbo.JobBenefitStage (JobId, BenefitId, BenefitValue)
SELECT 
    JobId,
    BenefitId,
    BenefitValue
FROM job.dbo.JobBenefit;