USE master;
DROP DATABASE jobDWStage;
CREATE DATABASE jobDWStage;					 --  Staging Database (jobDWStage)

USE jobDWStage;

-- Company Stage
CREATE TABLE CompanyStage (
    CompanyId INT,
    CompanyName NVARCHAR(255),
    CompanyLogo NVARCHAR(500),
    Address NVARCHAR(500)
);

-- City Stage
CREATE TABLE CityStage (
    CityId INT,
    CityName NVARCHAR(100),
    CityNameVI NVARCHAR(100)
);

-- Industry Stage
CREATE TABLE IndustryStage (
    IndustryId INT,
    IndustryName NVARCHAR(255),
    IndustryNameVI NVARCHAR(255)
);

-- JobFunction Stage
CREATE TABLE JobFunctionStage (
    JobFunctionId INT,
    JobFunctionName NVARCHAR(255),
    JobFunctionNameVI NVARCHAR(255)
);

-- GroupJobFunction Stage
CREATE TABLE GroupJobFunctionStage (
    GroupJobFunctionId INT,
    GroupJobFunctionName NVARCHAR(255),
    GroupJobFunctionNameVI NVARCHAR(255)
);

-- Skill Stage
CREATE TABLE SkillStage (
    SkillId INT,
    SkillName NVARCHAR(255)
);

-- BenefitType Stage
CREATE TABLE BenefitTypeStage (
    BenefitId INT,
    BenefitName NVARCHAR(255),
    BenefitNameVI NVARCHAR(255),
    BenefitIconName NVARCHAR(100)
);

-- Language Stage
CREATE TABLE LanguageStage (
    LanguageId INT,
    LanguageName NVARCHAR(100),
    LanguageNameVI NVARCHAR(100)
);

-- Job Stage
CREATE TABLE JobStage (
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
    LanguageId INT
);

-- WorkingLocation Stage
CREATE TABLE WorkingLocationStage (
    WorkingLocationId INT,
    JobId INT,
    Address NVARCHAR(500),
    CityId INT,
    Latitude FLOAT,
    Longitude FLOAT
);

-- JobIndustry Stage
CREATE TABLE JobIndustryStage (
    JobId INT,
    IndustryId INT
);

-- JobJobFunction Stage
CREATE TABLE JobJobFunctionStage (
    JobId INT,
    JobFunctionId INT
);

-- JobGroupJobFunction Stage
CREATE TABLE JobGroupJobFunctionStage (
    JobId INT,
    GroupJobFunctionId INT
);

-- JobSkill Stage
CREATE TABLE JobSkillStage (
    JobId INT,
    SkillId INT
);

-- JobBenefit Stage
CREATE TABLE JobBenefitStage (
    JobId INT,
    BenefitId INT,
    BenefitValue NVARCHAR(500)
);


-- Company
INSERT INTO CompanyStage (CompanyId, CompanyName, CompanyLogo, Address)
SELECT CompanyId, CompanyName, CompanyLogo, Address
FROM job.dbo.Company;

-- City
INSERT INTO CityStage (CityId, CityNameVI, CityName)
SELECT CityId, CityNameVI, CityName
FROM job.dbo.City;

-- Industry
INSERT INTO IndustryStage (IndustryId, IndustryName, IndustryNameVI)
SELECT IndustryId, IndustryName, IndustryNameVI
FROM job.dbo.Industry;

-- JobFunction
INSERT INTO JobFunctionStage (JobFunctionId, JobFunctionName, JobFunctionNameVI)
SELECT JobFunctionId, JobFunctionName, JobFunctionNameVI
FROM job.dbo.JobFunction;

-- GroupJobFunction
INSERT INTO GroupJobFunctionStage (GroupJobFunctionId, GroupJobFunctionName, GroupJobFunctionNameVI)
SELECT GroupJobFunctionId, GroupJobFunctionName, GroupJobFunctionNameVI
FROM job.dbo.GroupJobFunction;

-- Skill
INSERT INTO SkillStage (SkillId, SkillName)
SELECT SkillId, SkillName
FROM job.dbo.Skill;

-- BenefitType
INSERT INTO BenefitTypeStage (BenefitId, BenefitName, BenefitNameVI, BenefitIconName)
SELECT BenefitId, BenefitName, BenefitNameVI, BenefitIconName
FROM job.dbo.BenefitType;

-- Language
INSERT INTO LanguageStage (LanguageId, LanguageName, LanguageNameVI)
SELECT LanguageId, LanguageName, LanguageNameVI
FROM job.dbo.Language;

-- Job
INSERT INTO JobStage (JobId, JobTitle, JobUrl, CompanyId, SalaryMin, SalaryMax, SalaryCurrency, JobLevel,
                       TypeWorkingId, ApprovedOn, OnlineOn, ExpiredOn, IsUrgentJob, IsTopPriority, IsMobileHotJob,
                       JobDescription, JobRequirement, LanguageId)
SELECT JobId, JobTitle, JobUrl, CompanyId, SalaryMin, SalaryMax, SalaryCurrency, JobLevel,
       TypeWorkingId, ApprovedOn, OnlineOn, ExpiredOn, IsUrgentJob, IsTopPriority, IsMobileHotJob,
       JobDescription, JobRequirement, LanguageId
FROM job.dbo.Job;

-- WorkingLocation
INSERT INTO WorkingLocationStage (WorkingLocationId, JobId, Address, CityId, Latitude, Longitude)
SELECT WorkingLocationId, JobId, Address, CityId, Latitude, Longitude
FROM job.dbo.WorkingLocation;

-- JobIndustry
INSERT INTO JobIndustryStage (JobId, IndustryId)
SELECT JobId, IndustryId
FROM job.dbo.JobIndustry;

-- JobJobFunction
INSERT INTO JobJobFunctionStage (JobId, JobFunctionId)
SELECT JobId, JobFunctionId
FROM job.dbo.JobJobFunction;

-- JobGroupJobFunction
INSERT INTO JobGroupJobFunctionStage (JobId, GroupJobFunctionId)
SELECT JobId, GroupJobFunctionId
FROM job.dbo.JobGroupJobFunction;

-- JobSkill
INSERT INTO JobSkillStage (JobId, SkillId)
SELECT JobId, SkillId
FROM job.dbo.JobSkill;

-- JobBenefit
INSERT INTO JobBenefitStage (JobId, BenefitId, BenefitValue)
SELECT JobId, BenefitId, BenefitValue
FROM job.dbo.JobBenefit;
