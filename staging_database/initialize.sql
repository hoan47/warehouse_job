USE master;
GO
ALTER DATABASE jobDWStage SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO
DROP DATABASE jobDWStage;
GO
CREATE DATABASE jobDWStage; 					--  Staging Database (jobDWStage)
GO
ALTER DATABASE jobDWStage
SET RECOVERY SIMPLE
GO

USE jobDWStage;

-- Company Stage
CREATE TABLE CompanyStage (
    CompanyId INT,
    CompanyName NVARCHAR(255),
    CompanyLogo NVARCHAR(500),
    Address NVARCHAR(500),
    ETLInsertDate DATETIME DEFAULT GETDATE()
);

-- City Stage
CREATE TABLE CityStage (
    CityId INT,
    CityName NVARCHAR(100),
	CityNameVI NVARCHAR(100),
    ETLInsertDate DATETIME DEFAULT GETDATE()
);

-- Industry Stage
CREATE TABLE IndustryStage (
    IndustryId INT,
    IndustryName NVARCHAR(255),
    IndustryNameVI NVARCHAR(255),
    ETLInsertDate DATETIME DEFAULT GETDATE()
);

-- JobFunction Stage
CREATE TABLE JobFunctionStage (
    JobFunctionId INT,
    JobFunctionName NVARCHAR(255),
    JobFunctionNameVI NVARCHAR(255),
    ETLInsertDate DATETIME DEFAULT GETDATE()
);

-- GroupJobFunction Stage
CREATE TABLE GroupJobFunctionStage (
    GroupJobFunctionId INT,
    GroupJobFunctionName NVARCHAR(255),
    GroupJobFunctionNameVI NVARCHAR(255),
    ETLInsertDate DATETIME DEFAULT GETDATE()
);

-- Skill Stage
CREATE TABLE SkillStage (
    SkillId INT,
    SkillName NVARCHAR(255),
    ETLInsertDate DATETIME DEFAULT GETDATE()
);

-- BenefitType Stage
CREATE TABLE BenefitTypeStage (
    BenefitId INT,
    BenefitName NVARCHAR(255),
    BenefitNameVI NVARCHAR(255),
    BenefitIconName NVARCHAR(100),
    ETLInsertDate DATETIME DEFAULT GETDATE()
);

-- Language Stage
CREATE TABLE LanguageStage (
    LanguageId INT,
    LanguageName NVARCHAR(100),
    LanguageNameVI NVARCHAR(100),
    ETLInsertDate DATETIME DEFAULT GETDATE()
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
    LanguageId INT,
    ETLInsertDate DATETIME DEFAULT GETDATE(),
    JobFunctionId INT,
    GroupJobFunctionId INT
);

-- WorkingLocation Stage
CREATE TABLE WorkingLocationStage (
    WorkingLocationId INT,
    JobId INT,
    Address NVARCHAR(500),
    CityId INT,
    Latitude FLOAT,
    Longitude FLOAT,
    ETLInsertDate DATETIME DEFAULT GETDATE()
);

-- JobIndustry Stage
CREATE TABLE JobIndustryStage (
    JobId INT,
    IndustryId INT,
    ETLInsertDate DATETIME DEFAULT GETDATE()
);

-- JobSkill Stage
CREATE TABLE JobSkillStage (
    JobId INT,
    SkillId INT,
    ETLInsertDate DATETIME DEFAULT GETDATE()
);

-- JobBenefit Stage
CREATE TABLE JobBenefitStage (
    JobId INT,
    BenefitId INT,
    BenefitValue NVARCHAR(500),
    ETLInsertDate DATETIME DEFAULT GETDATE()
);