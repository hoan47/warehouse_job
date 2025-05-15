import json
import pandas as pd
from bs4 import BeautifulSoup
import os
from datetime import datetime
import uuid

# Hàm làm sạch HTML
def html_to_text(html_content):
    if not html_content:
        return ''
    soup = BeautifulSoup(html_content, "html.parser")
    text = soup.get_text(separator="\n")
    return "\n".join(line.strip() for line in text.splitlines() if line.strip())

# Hàm chuẩn hóa ngày
def format_date(date_str):
    if not date_str:
        return None
    try:
        if 'T' in date_str:  # ISO 8601: 2025-06-07T23:59:59+07:00
            dt = datetime.fromisoformat(date_str.replace('Z', '+00:00'))
            return dt.strftime('%Y-%m-%d %H:%M:%S')
        for fmt in ('%Y-%m-%d %H:%M:%S', '%Y-%m-%d', '%d/%m/%Y %H:%M:%S', '%d/%m/%Y'):
            try:
                return datetime.strptime(date_str, fmt).strftime('%Y-%m-%d %H:%M:%S')
            except ValueError:
                pass
        print(f"Invalid date: {date_str}")
        return None
    except Exception as e:
        print(f"Error parsing date {date_str}: {e}")
        return None

# Đọc file JSON
with open('vietnamworks.json', 'r', encoding='utf-8') as f:
    data = json.load(f)

# Khởi tạo danh sách dữ liệu
company_data = []
city_data = []
industry_data = []
job_function_data = []
group_job_function_data = []
skill_data = []
benefit_type_data = []
language_data = []
job_data = []
working_location_data = []
job_industry_data = []
job_skill_data = []
job_benefit_data = []

# Tạo thư mục lưu CSV
output_dir = '.'  # Sửa thành C:\data
os.makedirs(output_dir, exist_ok=True)


# Xử lý dữ liệu
for job in data:
    job_id = job.get('jobId')
    company_id = job.get('companyId')
    locations = job.get('workingLocations') or []
    benefits = job.get('benefits') or []
    industries = job.get('industriesV3') or []
    skills = job.get('skills') or []
    job_function_id = job.get('jobFunctionsV3').get('jobFunctionV3Id')
    group_job_function_id = job.get('groupJobFunctionsV3').get('groupJobFunctionV3Id')
    language_id = job.get('languageSelectedId')

    # Bảng Job
    job_data.append({
        'JobId': job_id,
        'JobTitle': job.get('jobTitle') or '',
        'JobUrl': job.get('jobUrl') or '',
        'CompanyId': company_id,
        'SalaryMin': job.get('salaryMin') if job.get('salaryMin') is not None else 0,
        'SalaryMax': job.get('salaryMax') if job.get('salaryMax') is not None else 0,
        'SalaryCurrency': job.get('salaryCurrency') or 'VND',
        'JobLevel': job.get('jobLevelVI') or '',
        'TypeWorkingId': job.get('typeWorkingId') if isinstance(job.get('typeWorkingId'), int) else 0,
        'ApprovedOn': format_date(job.get('approvedOn')),
        'OnlineOn': format_date(job.get('onlineOn')),
        'ExpiredOn': format_date(job.get('expiredOn')),
        'IsUrgentJob': 1 if job.get('isUrgentJob') else 0,
        'IsTopPriority': 1 if job.get('isTopPriority') else 0,
        'IsMobileHotJob': 1 if job.get('isMobileHotJob') else 0,
        'JobDescription': html_to_text(job.get('jobDescription')) or '',
        'JobRequirement': html_to_text(job.get('jobRequirement')) or '',
        'LanguageId': language_id,
        'JobFunctionId': job_function_id,
        'GroupJobFunctionId': group_job_function_id
    })

    # Bảng Company
    if isinstance(company_id, int):
        company_data.append({
            'CompanyId': company_id,
            'CompanyName': job.get('companyName') or '',
            'CompanyLogo': job.get('companyLogo') or '',
            'Address': job.get('address') or ''
        })

    # Bảng WorkingLocation và City
    for location in locations:
        city_id = location.get('cityId')
        if isinstance(city_id, int):

            working_location_id = location.get('workingLocationId')
            working_location_data.append({
                'WorkingLocationId': working_location_id,
                'JobId': job_id,
                'Address': location.get('address') or '',
                'CityId': city_id,
                'Latitude': float(location.get('geoLoc', {}).get('lat') or 0.0),
                'Longitude': float(location.get('geoLoc', {}).get('lon') or 0.0)
            })
            city_data.append({
                'CityId': city_id,
                'CityNameVI': location.get('cityNameVI') or '',
                'CityName': location.get('cityName') or ''
            })

    # Bảng Industry và JobIndustry
    for industry in industries:
        industry_id = industry.get('industryV3Id')
        if isinstance(industry_id, int):
            industry_data.append({
                'IndustryId': industry_id,
                'IndustryName': industry.get('industryV3Name') or '',
                'IndustryNameVI': industry.get('industryV3NameVI') or ''
            })
            job_industry_data.append({
                'JobId': job_id,
                'IndustryId': industry_id
            })

    # Bảng Skill và JobSkill
    for skill in skills:
        skill_id = skill.get('skillId')
        if isinstance(skill_id, int):
            skill_data.append({
                'SkillId': skill_id,
                'SkillName': skill.get('skillName') or ''
            })
            job_skill_data.append({
                'JobId': job_id,
                'SkillId': skill_id
            })

    # Bảng BenefitType và JobBenefit
    for benefit in benefits:
        benefit_id = benefit.get('benefitId')
        if isinstance(benefit_id, int):
            benefit_type_data.append({
                'BenefitId': benefit_id,
                'BenefitName': benefit.get('benefitName') or '',
                'BenefitNameVI': benefit.get('benefitNameVI') or '',
                'BenefitIconName': benefit.get('benefitIconName') or ''
            })
            benefit_value = benefit.get('benefitValue') or ''
            job_benefit_data.append({
                'JobId': job_id,
                'BenefitId': benefit_id,
                'BenefitValue': benefit_value
            })

    # Bảng Language
    if isinstance(language_id, int):
        language_data.append({
            'LanguageId': language_id,
            'LanguageName': job.get('languageSelected') or '',
            'LanguageNameVI': job.get('languageSelectedVI') or ''
        })

    # Bảng JobFunctions
    if isinstance(job_function_id, int):
        job_function_data.append({
            'JobFunctionId': job_function_id,
            'JobFunctionName': job.get('jobFunctionsV3').get('jobFunctionV3Name') or '',
            'JobFunctionNameVI': job.get('jobFunctionsV3').get('jobFunctionV3NameVI') or ''
        })

    # Bảng GroupJobFunction và JobGroupJobFunction
    if isinstance(group_job_function_id, int):
        group_job_function_data.append({
            'GroupJobFunctionId': group_job_function_id,
            'GroupJobFunctionName': job.get('groupJobFunctionsV3').get('groupJobFunctionV3Name') or '',
            'GroupJobFunctionNameVI': job.get('groupJobFunctionsV3').get('groupJobFunctionV3NameVI') or ''
        })

# Tạo DataFrame và loại bỏ trùng lặp
company_df = pd.DataFrame(company_data).drop_duplicates(subset=['CompanyId'])
city_df = pd.DataFrame(city_data).drop_duplicates(subset=['CityId'])
industry_df = pd.DataFrame(industry_data).drop_duplicates(subset=['IndustryId'])
job_function_df = pd.DataFrame(job_function_data).drop_duplicates(subset=['JobFunctionId'])
group_job_function_df = pd.DataFrame(group_job_function_data).drop_duplicates(subset=['GroupJobFunctionId'])
skill_df = pd.DataFrame(skill_data).drop_duplicates(subset=['SkillId'])
benefit_type_df = pd.DataFrame(benefit_type_data).drop_duplicates(subset=['BenefitId'])
language_df = pd.DataFrame(language_data).drop_duplicates(subset=['LanguageId'])
job_df = pd.DataFrame(job_data).drop_duplicates(subset=['JobId'])
working_location_df = pd.DataFrame(working_location_data).drop_duplicates(subset=['WorkingLocationId'])
job_industry_df = pd.DataFrame(job_industry_data).drop_duplicates(subset=['JobId', 'IndustryId'])
job_skill_df = pd.DataFrame(job_skill_data).drop_duplicates(subset=['JobId', 'SkillId'])
job_benefit_df = pd.DataFrame(job_benefit_data).drop_duplicates(subset=['JobId', 'BenefitId'])

# Lưu vào CSV
company_df.to_csv(os.path.join(output_dir, 'company.csv'), index=False, encoding='utf-8-sig')
city_df.to_csv(os.path.join(output_dir, 'city.csv'), index=False, encoding='utf-8-sig')
industry_df.to_csv(os.path.join(output_dir, 'industry.csv'), index=False, encoding='utf-8-sig')
job_function_df.to_csv(os.path.join(output_dir, 'job_function.csv'), index=False, encoding='utf-8-sig')
group_job_function_df.to_csv(os.path.join(output_dir, 'group_job_function.csv'), index=False, encoding='utf-8-sig')
skill_df.to_csv(os.path.join(output_dir, 'skill.csv'), index=False, encoding='utf-8-sig')
benefit_type_df.to_csv(os.path.join(output_dir, 'benefit_type.csv'), index=False, encoding='utf-8-sig')
language_df.to_csv(os.path.join(output_dir, 'language.csv'), index=False, encoding='utf-8-sig')
job_df.to_csv(os.path.join(output_dir, 'job.csv'), index=False, encoding='utf-8-sig')
working_location_df.to_csv(os.path.join(output_dir, 'working_location.csv'), index=False, encoding='utf-8-sig')
job_industry_df.to_csv(os.path.join(output_dir, 'job_industry.csv'), index=False, encoding='utf-8-sig')
job_skill_df.to_csv(os.path.join(output_dir, 'job_skill.csv'), index=False, encoding='utf-8-sig')
job_benefit_df.to_csv(os.path.join(output_dir, 'job_benefit.csv'), index=False, encoding='utf-8-sig')
