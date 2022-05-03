import cx_Oracle
username = 'S211_IEOZ6221_NILOV'
password = 'qazxswedcvfrTGB123'
#dsn_tns = cx_Oracle.makedsn('adb.uk-london-1.oraclecloud.com', 1522, service_name='qvnagmgdg3tpsms_db21_high.adb.oraclecloud.com') # if needed, place an 'r' before any parameter in order to address special characters such as '\'.
dsn_tns = '(description= (retry_count=20)(retry_delay=3)(address=(protocol=tcps)(port=1522)(host=adb.uk-london-1.oraclecloud.com))(connect_data=(service_name=qvnagmgdg3tpsms_db21_high.adb.oraclecloud.com))(security=(ssl_server_cert_dn="CN=adwc.eucom-central-1.oraclecloud.com, OU=Oracle BMCS FRANKFURT, O=Oracle Corporation, L=Redwood City, ST=California, C=US")))'
connection = cx_Oracle.connect(user=username,password=password,dsn=dsn_tns)
print("Database version:", connection.version)
print('Добро пожаловать, Тёмик)')
cursor = connection.cursor()

for row in cursor.execute('select * from zone'):
  print(row)
print(f'Количество зон = {cursor.arraysize}')