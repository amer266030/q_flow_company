# QFlow (Company)

QFlow (Company) is a Flutter-based application developed to streamline the visitor experience at job fairs hosted by Tuwaiq Academy. It addresses challenges such as long queue wait times, access to company information, and the need to carry multiple CV copies. This fully functional app allows visitors to browse company details, join queues, receive real-time notifications, and rate or save companies for later, providing a more efficient and seamless event experience.

![App Clip](q_flow_company.gif)

## Table of Contents

- [App Overview](#app-overview)
- [Tools/Technologies](#toolstechnologies)
- [Features](#features)
- [Data Models](#data-models)
- [Design Philosophy](#design-philosophy)
- [Getting Started](#getting-started)
- [Future Enhancements](#future-enhancements)
- [Created By](#created-by)

## App Overview

### Tools/Technologies

1. **Dart/Flutter**
   - Programing Language and framework used to build the QFlow apps for both iOS and Android from a single codebase.

2. **Supabase**
   - Provide efficient backend management, handling database functions and user authentication.

3. **One Signal**
   - A push notification service that sends real-time notifications  about queue status and upcoming interviews.

4. **Figma**
   - A collaborative design platform for creating high-quality wireframes and prototypes.

5. **Github**
   - Enables efficient collaboration, allowing our team to manage code.

6. **Excel**
   - Manage/control invitations and attendance of Companies and Visitors.

### Features

1. **Onboarding**
   - Welcomes company representatives and provides an overview of app capabilities.

2. **Authentication**
   - Only emails invited by the event organizer can sign in.
   - Uses email OTP verification for secure access without a password.

3. **Home**
   - Displays a QR code for attendance verification.
   - Shows a list of events, including past events and the currently selected event.
   - Allows recruiters to open or close the queue, controlling interview availability.
   - Organizes visitor applications into three tabs:
      - In Queue: Visitors currently in line, with a clear view of the next person.
      - Applied: Visitors who have completed their interviews.
      - Bookmarked: Profiles bookmarked by recruiters for easy access post-event.
   -	Provides an option to start the next interview with the visitor waiting in line.

4. **Interview**
   - Displays detailed visitor information, including CV, social links, and contact details.
   - Allows interviewers to cancel the interview if the visitor does not show up.
   - Enables interview ratings and comment entry on candidates before concluding and moving to the next interview.

5. **Profile Drawer**
   - Allows companies to update profile details, including name, description, social links, and current job openings.
   - Provides options to view the privacy policy, enable/disable notifications, switch app language (Arabic/English), toggle light/dark themes, and log out.


### Data Models

The app includes more than 11 data models that connect with database tables. The main ones are for:

- **Visitor Profile:** Stores visitor details, CV, and social links.
- **Company:** Contains company information, job openings, and queue details.
- **Interview:** Manages booked interviews, including status and ratings.
- **Bookmark:** Tracks bookmarked companies for future reference.
- **Event:** Manages events the company has participated in, including visitor queues.

### Design Philosophy

- **Efficient Queue Management:** Real-time queue updates help recruiters stay organized and manage interview flow smoothly.
- **Streamlined Candidate Tracking:** Bookmarking and interview notes make it easy for recruiters to follow up post-event.
- **Enhanced User Interface:**  An organized UI with clear tabs and easy access to key actions ensures seamless navigation.

### Functionality

The QFlow Company App offers recruiters a robust toolset for managing job fair interviews. With options to open/close queues, manage visitor information, and rate interviews, the app optimizes recruiter interactions and provides a complete overview of the hiring process during job fairs.

## Getting Started

### Prerequisites

- Flutter SDK
- A code editor (such as VS Code or Android Studio)

### Installation

1. Clone the repository:

```
   git clone https://github.com/amer266030/q_flow_company
```

3. Get the dependencies:

    
```
   flutter pub get
```

4. Run the app:
    
```
   flutter run
```

### Future Enhancements

* Follow-Up Management: Additional tools to simplify post-event follow-up with saved profiles.

## Created By

**Amer Alyusuf**
- [Portfolio](https://amer266030.github.io)
- [Resume](https://amer266030.github.io/assets/pdf/Amer_CV.pdf)
- [LinkedIn](https://www.linkedin.com/in/amer-alyusuf)

**Yara Albouq**
- [Portfolio](https://bind.link/@yaraalbouq)
- [Resume](https://drive.google.com/file/d/1H0d1yBl9JCLyyc3Uwz3582EW3uy3U3HE/view?usp=drivesdk)
- [LinkedIn](https://www.linkedin.com/in/yaraalbouq)

**Abdullah Alshammari**
- [Portfolio](https://bind.link/@abdullah-al-shammari)
- [Resume](https://www.dropbox.com/scl/fi/usjo2vcuarjhqaulu226e/Abdullah_Alshammari_CV.pdf?rlkey=k297kmstimne5g017fdm9bdkd&st=jwe6dwpc&dl=0)
- [LinkedIn](https://www.linkedin.com/in/abumukhlef)