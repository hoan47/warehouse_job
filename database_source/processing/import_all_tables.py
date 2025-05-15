import os
import pyodbc
import pandas as pd

# Hàm chuyển đổi kiểu dữ liệu
# Hàm ép kiểu cho các DataFrame từ các file CSV
def convert_dataframe_types(df, table_name):
    if table_name == 'Company':
        df['CompanyId'] = df['CompanyId'].astype('Int64')  # Dùng Int64 để xử lý NaN
        df['CompanyName'] = df['CompanyName'].astype(str)
        df['CompanyLogo'] = df['CompanyLogo'].astype(str)
        df['Address'] = df['Address'].astype(str)
    
    elif table_name == 'City':
        df['CityId'] = df['CityId'].astype('Int64')
        df['CityNameVI'] = df['CityNameVI'].astype(str)
        df['CityName'] = df['CityName'].astype(str)
    
    elif table_name == 'Industry':
        df['IndustryId'] = df['IndustryId'].astype('Int64')
        df['IndustryName'] = df['IndustryName'].astype(str)
        df['IndustryNameVI'] = df['IndustryNameVI'].astype(str)
    
    elif table_name == 'JobFunction':
        df['JobFunctionId'] = df['JobFunctionId'].astype('Int64')
        df['JobFunctionName'] = df['JobFunctionName'].astype(str)
        df['JobFunctionNameVI'] = df['JobFunctionNameVI'].astype(str)
    
    elif table_name == 'GroupJobFunction':
        df['GroupJobFunctionId'] = df['GroupJobFunctionId'].astype('Int64')
        df['GroupJobFunctionName'] = df['GroupJobFunctionName'].astype(str)
        df['GroupJobFunctionNameVI'] = df['GroupJobFunctionNameVI'].astype(str)
    
    elif table_name == 'Skill':
        df['SkillId'] = df['SkillId'].astype('Int64')
        df['SkillName'] = df['SkillName'].astype(str)
    
    elif table_name == 'BenefitType':
        df['BenefitId'] = df['BenefitId'].astype('Int64')
        df['BenefitName'] = df['BenefitName'].astype(str)
        df['BenefitNameVI'] = df['BenefitNameVI'].astype(str)
        df['BenefitIconName'] = df['BenefitIconName'].astype(str)
    
    elif table_name == 'Language':
        df['LanguageId'] = df['LanguageId'].astype('Int64')
        df['LanguageName'] = df['LanguageName'].astype(str)
        df['LanguageNameVI'] = df['LanguageNameVI'].astype(str)
    
    elif table_name == 'Job':
        df['JobId'] = df['JobId'].astype('Int64')
        df['JobTitle'] = df['JobTitle'].astype(str)
        df['JobUrl'] = df['JobUrl'].astype(str)
        df['CompanyId'] = df['CompanyId'].astype('Int64')
        df['SalaryMin'] = df['SalaryMin'].astype(float)
        df['SalaryMax'] = df['SalaryMax'].astype(float)
        df['SalaryCurrency'] = df['SalaryCurrency'].astype(str)
        df['JobLevel'] = df['JobLevel'].astype(str)
        df['TypeWorkingId'] = df['TypeWorkingId'].astype('Int64')
        df['ApprovedOn'] = pd.to_datetime(df['ApprovedOn'], errors='coerce')
        df['OnlineOn'] = pd.to_datetime(df['OnlineOn'], errors='coerce')
        df['ExpiredOn'] = pd.to_datetime(df['ExpiredOn'], errors='coerce')
        df['IsUrgentJob'] = df['IsUrgentJob'].astype('Int64')
        df['IsTopPriority'] = df['IsTopPriority'].astype('Int64')
        df['IsMobileHotJob'] = df['IsMobileHotJob'].astype('Int64')
        df['JobDescription'] = df['JobDescription'].astype(str)
        df['JobRequirement'] = df['JobRequirement'].astype(str)
        df['LanguageId'] = df['LanguageId'].astype('Int64')
        df['JobFunctionId'] = df['JobFunctionId'].astype('Int64')
        df['GroupJobFunctionId'] = df['GroupJobFunctionId'].astype('Int64')
    
    elif table_name == 'WorkingLocation':
        df['WorkingLocationId'] = df['WorkingLocationId'].astype('Int64')
        df['JobId'] = df['JobId'].astype('Int64')
        df['Address'] = df['Address'].astype(str)
        df['CityId'] = df['CityId'].astype('Int64')
        df['Latitude'] = df['Latitude'].astype(float)
        df['Longitude'] = df['Longitude'].astype(float)
    
    elif table_name == 'JobIndustry':
        df['JobId'] = df['JobId'].astype('Int64')
        df['IndustryId'] = df['IndustryId'].astype('Int64')
    
    elif table_name == 'JobSkill':
        df['JobId'] = df['JobId'].astype('Int64')
        df['SkillId'] = df['SkillId'].astype('Int64')
    
    elif table_name == 'JobBenefit':
        df['JobId'] = df['JobId'].astype('Int64')
        df['BenefitId'] = df['BenefitId'].astype('Int64')
        df['BenefitValue'] = df['BenefitValue'].astype(str)
    
    return df



def insert_df(df, table_name, columns):
    try:
        placeholders = ', '.join(['?' for _ in columns])
        query = f"INSERT INTO {table_name} ({', '.join(columns)}) VALUES ({placeholders})"
        values = [
            tuple(row[col] if pd.notnull(row[col]) else None for col in columns)
            for _, row in df.iterrows()
        ]
        cursor.executemany(query, values)
        conn.commit()
        print(f"✅ Inserted {len(df)} rows into {table_name}")
    except Exception as e:
        print(f"❌ Error inserting into {table_name}: {e}")

try:
    conn = pyodbc.connect('DRIVER={SQL Server};SERVER=localhost;DATABASE=job;Trusted_Connection=yes')
    cursor = conn.cursor()
    cursor.execute("SELECT 1")
    print("✅ Connected successfully!")

    # Danh sách các file cần import
    imports = [
        ('company.csv', 'Company', ['CompanyId', 'CompanyName', 'CompanyLogo', 'Address']),
        ('city.csv', 'City', ['CityId', 'CityNameVI', 'CityName']),
        ('industry.csv', 'Industry', ['IndustryId', 'IndustryName', 'IndustryNameVI']),
        ('job_function.csv', 'JobFunction', ['JobFunctionId', 'JobFunctionName', 'JobFunctionNameVI']),
        ('group_job_function.csv', 'GroupJobFunction', ['GroupJobFunctionId', 'GroupJobFunctionName', 'GroupJobFunctionNameVI']),
        ('skill.csv', 'Skill', ['SkillId', 'SkillName']),
        ('benefit_type.csv', 'BenefitType', ['BenefitId', 'BenefitName', 'BenefitNameVI', 'BenefitIconName']),
        ('language.csv', 'Language', ['LanguageId', 'LanguageName', 'LanguageNameVI']),
        ('job.csv', 'Job', ['JobId', 'JobTitle', 'JobUrl', 'CompanyId', 'SalaryMin', 'SalaryMax', 'SalaryCurrency', 'JobLevel', 'TypeWorkingId', 'ApprovedOn', 'OnlineOn', 'ExpiredOn', 'IsUrgentJob', 'IsTopPriority', 'IsMobileHotJob', 'JobDescription', 'JobRequirement', 'LanguageId', 'JobFunctionId', 'GroupJobFunctionId']),
        ('working_location.csv', 'WorkingLocation', ['WorkingLocationId', 'JobId', 'Address', 'CityId', 'Latitude', 'Longitude']),
        ('job_industry.csv', 'JobIndustry', ['JobId', 'IndustryId']),
        ('job_skill.csv', 'JobSkill', ['JobId', 'SkillId']),
        ('job_benefit.csv', 'JobBenefit', ['JobId', 'BenefitId', 'BenefitValue']),
    ]

    for file, table, cols in imports:
        if os.path.exists(file):
            df = pd.read_csv(file)
            df = pd.read_csv(file)
            # Chèn dữ liệu vào bảng SQL Server
            insert_df(convert_dataframe_types(df, table), table, cols)
        else:
            print(f"⚠️ File {file} không tồn tại!")

except Exception as e:
    print("❌ Kết nối thất bại. Lỗi:", e)

finally:
    try:
        conn.close()
        print("✅ Đóng kết nối.")
    except:
        pass
