# Company Website - Job Application Platform<br />
This is a simple Ruby on Rails 7 application built for a company website, providing a job listing and application platform. Users can view available job openings, submit applications, and upload their resumes. Admins can review the applications, calculate a fit score for each application, and manage the applications effectively.<br />

## Features<br />
**Home Page**: A welcoming homepage with key company information and navigation links.<br />
**About Us Page**: A page that provides company details, mission, and history.<br />
**Careers Page**: A page displaying available job openings.<br />
**Job Application**: Users can submit their applications with basic details (name, email, experience) and upload their resume (PDF).<br />
**Fit Score Calculation**: Once an application is submitted, a fit score is calculated based on the applicant's details and compared with the job requirements.<br />
**Admin Dashboard**: Admins can manage job applications, review the fit scores, and easily interact with candidates.<br />

## Application Flow <br />
**Home Page**: Visitors can learn more about the company and navigate to other sections.<br />
**Careers Page**: Displays a list of job openings.<br />
-Job Application Form: Applicants fill out their details and upload a resume.<br />
-After submission, the application is processed, and a fit score is calculated.<br />
-The form uses Turbo Streams for a seamless user experience.<br />
**Admin Panel**: Admin users can:<br />
-View and manage all job applications.<br />
-Review fit scores and status of each application.<br />
-Interact with applicants for further communication.<br />

## Admin Access <br />
To manage applications and review fit scores, you must log in as an admin. Admin access is granted when creating the first user during setup. You can modify the 
is_admin field in the database to grant admin rights to any user.
