rem 恢复环境变量
wmic ENVIRONMENT where "name='APP_HOME'" delete>NUL 2>&1
wmic ENVIRONMENT where "name='OS_ARCHITECTURE'" delete>NUL 2>&1