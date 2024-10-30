# IRIS_dharineesh-231EE113
I have implemented a basic Hostel allotment app that helps a user choose his hostel during the process of hostel registration.
Some of the basic features i have implemeted is:
  a. User/Admin login page which leads you to their respective Home/Dashboard pages.
    i have used Firebase Authentication for this feature of the app. It requires the user/admin to login with their username/password.

    
  b. The User Home page features User data like Name, branch, roll no and hostel/room details.It features a register button to register yourself in a particular hostsel. The user will be able to choose his Hostel, wing as well as room.
This completes the registration process which is subsequently updated in the UserProfile page.I have used Firebase Cloudstore to store all userdetails.


c. on registration, the change hostel button is shown which gives the user an option to change his hostel.On changing his hostel, a request is sent to admin to accept/refuse.

d. similar to user profile,on login the admin may see details of all students as well as the requests for hostel/room changes.
on accepting the userdata is automatically updated. I have used another collection in firebase Firestore for this purpose.

e. i have also implemented dark/light mode based on mobile settings.

I have used Bloc state management for a few features but didnt implement It for the hostel Allotment/change segment of the app due to time constraints.I did take help from chatGpt for simplifying code, few logics/methods/syntax/ and it did help me learn a lot.I also used it to remove/correct errors in code.

![WhatsApp Image 2024-10-30 at 21 32 03_4b21db51](https://github.com/user-attachments/assets/6ce0c343-0c7d-48ac-a5d9-e6480b66b67f)
![WhatsApp Image 2024-10-30 at 21 32 02_6d268d49](https://github.com/user-attachments/assets/824682d7-e003-4758-b507-d1a2260de21d)
![WhatsApp Image 2024-10-30 at 21 32 02_823d0b4e](https://github.com/user-attachments/assets/a2c7e824-dad5-4fca-a8e2-7ff3f057b969)
![WhatsApp Image 2024-10-30 at 21 32 01_3e997a6d](https://github.com/user-attachments/assets/9516098a-de9e-46c6-b3a9-c3ae99306d27)
![WhatsApp Image 2024-10-30 at 21 32 01_1141be0b](https://github.com/user-attachments/assets/bcf20c23-6809-4e1d-8b3d-b9cf857c5606)
![WhatsApp Image 2024-10-30 at 21 32 01_30f61e63](https://github.com/user-attachments/assets/3f23407b-3b75-454e-836f-49e5246c29e2)
![WhatsApp Image 2024-10-30 at 21 32 00_b87f6714](https://github.com/user-attachments/assets/3fdc8fa1-392b-4c5b-b276-f7313e6c2e59)
![WhatsApp Image 2024-10-30 at 21 32 00_0e5b209a](https://github.com/user-attachments/assets/4791f851-ceb1-432f-8efc-da5dab06684a)
![WhatsApp Image 2024-10-30 at 21 31 59_99d36dbf](https://github.com/user-attachments/assets/2e7dcf2a-5c0f-42a2-ad92-cd98efbc49c8)
![WhatsApp Image 2024-10-30 at 21 31 58_343b4e31](https://github.com/user-attachments/assets/066f9b46-9335-435c-82a9-ffa4c22d0871)
![WhatsApp Image 2024-10-30 at 21 31 58_7ea78d50](https://github.com/user-attachments/assets/c029c552-f944-42a2-8505-6ce4c0eeb06c)
![WhatsApp Image 2024-10-30 at 21 31 57_474477d9](https://github.com/user-attachments/assets/1253c5f2-2af9-4a10-89b6-e06e77a3a1e6)






I have not implemented few features like Hive,FCM,and allowing user to apply for leaves. I do have a basic idea about the above ones but couldnt implement them as I am a beginner and i felt My learning phase to be too steep but did enjoy the process of  doing the tasks a lot.\





