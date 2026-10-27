SPDD FACI UPD — XAMPP SETUP

1. Extract spdd_faci_upd.zip.
2. Copy the spdd_faci_upd folder into C:\xampp\htdocs\
3. Start Apache and MySQL from XAMPP Control Panel.
4. Open http://localhost/phpmyadmin/
5. Open the SQL tab and run the separate file spdd_faci_upd.sql.
6. Visit http://localhost/spdd_faci_upd/

DATABASE
- Database name: spdd_faci_upd
- MySQL username: root (default XAMPP)
- MySQL password: blank by default; change config.php if yours differs.
- The SQL file is supplied separately and is not inside the ZIP.

DEMO LOGIN ACCOUNTS (created by PHP on first app visit after importing SQL)
- Admin: username admin, password 1234
- Electrical department: username electrical, password 12345
- Plumbing department: username plumbing, password 12345
- IT Support department: username it_support, password 12345
- Civil Maintenance department: username civil, password 12345
- Cleaning department: username cleaning, password 12345

Students and teachers create their own accounts through Create account. Passwords are stored using PHP password_hash(). Change demo passwords before any public deployment.

FEATURES
- Initial dark landing screen with a pull-cord lamp and a Features drawer.
- Clicking Sign in opens a black/dark login interface without the lamp.
- Clicking Create account opens a matching black/dark registration interface without the lamp.
- Role-based sidebar and dashboards for students, teachers, admin and department users.
- Report facility issues with category, building, floor, room, description and optional photo.
- Admin assigns priority and department; departments update status and notes.
- Issue status history, issue detail, dashboard reports, profile management and reviews.
- Students/teachers can review their own resolved issue once; admins can view submitted reviews.
- Uploads are stored in uploads/ and only JPG, PNG or WEBP files up to 3 MB are accepted.

Google and GitHub buttons are not implemented in this project because OAuth credentials were not supplied.
