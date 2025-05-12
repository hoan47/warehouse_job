USE master;
DROP DATABASE jobDWStage;
CREATE DATABASE jobDWStage;					 --  Staging Database (jobDWStage)

USE jobDWStage;

-- Company Stage
CREATE TABLE Company_Stage (
    CompanyId INT,
    CompanyName NVARCHAR(255),
    CompanyLogo NVARCHAR(500),
    Address NVARCHAR(500),
    ETL_InsertDate DATETIME DEFAULT GETDATE()
);

-- City Stage
CREATE TABLE City_Stage (
    CityId INT,
    CityNameVI NVARCHAR(100),
    CityName NVARCHAR(100),
    ETL_InsertDate DATETIME DEFAULT GETDATE()
);

-- Industry Stage
CREATE TABLE Industry_Stage (
    IndustryId INT,
    IndustryName NVARCHAR(255),
    IndustryNameVI NVARCHAR(255),
    ETL_InsertDate DATETIME DEFAULT GETDATE()
);

-- JobFunction Stage
CREATE TABLE JobFunction_Stage (
    JobFunctionId INT,
    JobFunctionName NVARCHAR(255),
    JobFunctionNameVI NVARCHAR(255),
    ETL_InsertDate DATETIME DEFAULT GETDATE()
);

-- GroupJobFunction Stage
CREATE TABLE GroupJobFunction_Stage (
    GroupJobFunctionId INT,
    GroupJobFunctionName NVARCHAR(255),
    GroupJobFunctionNameVI NVARCHAR(255),
    ETL_InsertDate DATETIME DEFAULT GETDATE()
);

-- Skill Stage
CREATE TABLE Skill_Stage (
    SkillId INT,
    SkillName NVARCHAR(255),
    ETL_InsertDate DATETIME DEFAULT GETDATE()
);

-- BenefitType Stage
CREATE TABLE BenefitType_Stage (
    BenefitId INT,
    BenefitName NVARCHAR(255),
    BenefitNameVI NVARCHAR(255),
    BenefitIconName NVARCHAR(100),
    ETL_InsertDate DATETIME DEFAULT GETDATE()
);

-- Language Stage
CREATE TABLE Language_Stage (
    LanguageId INT,
    LanguageName NVARCHAR(100),
    LanguageNameVI NVARCHAR(100),
    ETL_InsertDate DATETIME DEFAULT GETDATE()
);

-- Job Stage
CREATE TABLE Job_Stage (
    JobId INT,
    JobTitle NVARCHAR(255),
    JobUrl NVARCHAR(500),
    CompanyId INT,
    SalaryMin INT,
    SalaryMax INT,
    SalaryCurrency NVARCHAR(10),
    JobLevel NVARCHAR(100),
    TypeWorkingId INT,
    ApprovedOn DATETIME,
    OnlineOn DATETIME,
    ExpiredOn DATETIME,
    IsUrgentJob BIT,
    IsTopPriority BIT,
    IsMobileHotJob BIT,
    JobDescription NVARCHAR(MAX),
    JobRequirement NVARCHAR(MAX),
    LanguageId INT,
    ETL_InsertDate DATETIME DEFAULT GETDATE()
);

-- WorkingLocation Stage
CREATE TABLE WorkingLocation_Stage (
    WorkingLocationId INT,
    JobId INT,
    Address NVARCHAR(500),
    CityId INT,
    Latitude FLOAT,
    Longitude FLOAT,
    ETL_InsertDate DATETIME DEFAULT GETDATE()
);

-- JobIndustry Stage
CREATE TABLE JobIndustry_Stage (
    JobId INT,
    IndustryId INT,
    ETL_InsertDate DATETIME DEFAULT GETDATE()
);

-- JobJobFunction Stage
CREATE TABLE JobJobFunction_Stage (
    JobId INT,
    JobFunctionId INT,
    ETL_InsertDate DATETIME DEFAULT GETDATE()
);

-- JobGroupJobFunction Stage
CREATE TABLE JobGroupJobFunction_Stage (
    JobId INT,
    GroupJobFunctionId INT,
    ETL_InsertDate DATETIME DEFAULT GETDATE()
);

-- JobSkill Stage
CREATE TABLE JobSkill_Stage (
    JobId INT,
    SkillId INT,
    ETL_InsertDate DATETIME DEFAULT GETDATE()
);

-- JobBenefit Stage
CREATE TABLE JobBenefit_Stage (
    JobId INT,
    BenefitId INT,
    BenefitValue NVARCHAR(500),
    ETL_InsertDate DATETIME DEFAULT GETDATE()
);


-- Company
INSERT INTO Company_Stage (CompanyId, CompanyName, CompanyLogo, Address)
SELECT CompanyId, CompanyName, CompanyLogo, Address
FROM job.dbo.Company;

-- City
INSERT INTO City_Stage (CityId, CityNameVI, CityName)
SELECT CityId, CityNameVI, CityName
FROM job.dbo.City;

-- Industry
INSERT INTO Industry_Stage (IndustryId, IndustryName, IndustryNameVI)
SELECT IndustryId, IndustryName, IndustryNameVI
FROM job.dbo.Industry;

-- JobFunction
INSERT INTO JobFunction_Stage (JobFunctionId, JobFunctionName, JobFunctionNameVI)
SELECT JobFunctionId, JobFunctionName, JobFunctionNameVI
FROM job.dbo.JobFunction;

-- GroupJobFunction
INSERT INTO GroupJobFunction_Stage (GroupJobFunctionId, GroupJobFunctionName, GroupJobFunctionNameVI)
SELECT GroupJobFunctionId, GroupJobFunctionName, GroupJobFunctionNameVI
FROM job.dbo.GroupJobFunction;

-- Skill
INSERT INTO Skill_Stage (SkillId, SkillName)
SELECT SkillId, SkillName
FROM job.dbo.Skill;

-- BenefitType
INSERT INTO BenefitType_Stage (BenefitId, BenefitName, BenefitNameVI, BenefitIconName)
SELECT BenefitId, BenefitName, BenefitNameVI, BenefitIconName
FROM job.dbo.BenefitType;

-- Language
INSERT INTO Language_Stage (LanguageId, LanguageName, LanguageNameVI)
SELECT LanguageId, LanguageName, LanguageNameVI
FROM job.dbo.Language;

-- Job
INSERT INTO Job_Stage (JobId, JobTitle, JobUrl, CompanyId, SalaryMin, SalaryMax, SalaryCurrency, JobLevel,
                       TypeWorkingId, ApprovedOn, OnlineOn, ExpiredOn, IsUrgentJob, IsTopPriority, IsMobileHotJob,
                       JobDescription, JobRequirement, LanguageId)
SELECT JobId, JobTitle, JobUrl, CompanyId, SalaryMin, SalaryMax, SalaryCurrency, JobLevel,
       TypeWorkingId, ApprovedOn, OnlineOn, ExpiredOn, IsUrgentJob, IsTopPriority, IsMobileHotJob,
       JobDescription, JobRequirement, LanguageId
FROM job.dbo.Job;

-- WorkingLocation
INSERT INTO WorkingLocation_Stage (WorkingLocationId, JobId, Address, CityId, Latitude, Longitude)
SELECT WorkingLocationId, JobId, Address, CityId, Latitude, Longitude
FROM job.dbo.WorkingLocation;

-- JobIndustry
INSERT INTO JobIndustry_Stage (JobId, IndustryId)
SELECT JobId, IndustryId
FROM job.dbo.JobIndustry;

-- JobJobFunction
INSERT INTO JobJobFunction_Stage (JobId, JobFunctionId)
SELECT JobId, JobFunctionId
FROM job.dbo.JobJobFunction;

-- JobGroupJobFunction
INSERT INTO JobGroupJobFunction_Stage (JobId, GroupJobFunctionId)
SELECT JobId, GroupJobFunctionId
FROM job.dbo.JobGroupJobFunction;

-- JobSkill
INSERT INTO JobSkill_Stage (JobId, SkillId)
SELECT JobId, SkillId
FROM job.dbo.JobSkill;

-- JobBenefit
INSERT INTO JobBenefit_Stage (JobId, BenefitId, BenefitValue)
SELECT JobId, BenefitId, BenefitValue
FROM job.dbo.JobBenefit;
