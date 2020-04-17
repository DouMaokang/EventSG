# EventSG
EventSG is a project developed by a team of five for Software Engineering course in NTU

[[Backend link]](https://github.com/DouMaokang/EventSG-Backend)

## Description
EventSG is created for event creation, registration, rating and venue renting for event organizers, participants and venue owners based in Singapore. 

It allows people to easily find events of their interest and enrich their social life. Event organizers can utilize such a platform to manage, promote and improve their events. Meanwhile, it bridges the gap between event organizers and venue owners so that event organizers can rent venues of their preferences.

## Product Perspective
EventSG is a newly developed application for iOS devices. It is created for everyone in Singapore who is interested in finding an event to participate or organize. It is also a platform for venue owners to rent their property for events.

## Product Features
- A new user to the application can register an account, which requires the user to key in personal information such as email and username etc.
- A user can login to the system with his email and password, or log out from his profile page
- A user can create an event with event information such as date and location, allowing other users to register.
- A user can create a venue with venue information such as location and price, allowing other users to rent
- The system would send notifications to users when he/she receives a new event feedback, when other users rent his venue, when a user registers/deregisters his/her event or when an event organizer he/she follows posts a new event.
- When posting an event, the event organizer can browse the venue listing and book venues for his event
- A user can add a feedback, which includes a comment and a rating to an event.
- A user can check details of an event, which includes event name, time, and location etc.
- Event organizers can check feedback for his event, which includes an overall rating and each individual feedback provided by other users.
- A user can browse all events, his/her upcoming events or recommended events.
- A user can search for an event, or filter events by category
- A user can save and unsave an event
- A user registers or deregisters an event
- A user can check his/her profile page, which includes his avatar, username, saved events, created events and etc.

## Photo Gallery
<p align="center">
  <img src="https://github.com/DouMaokang/EventSG/blob/master/doc/IMG_2286.PNG" width="250">
  <img src="https://github.com/DouMaokang/EventSG/blob/master/doc/IMG_2287.PNG" width="250">
  <img src="https://github.com/DouMaokang/EventSG/blob/master/doc/IMG_2288.PNG" width="250">
  <img src="https://github.com/DouMaokang/EventSG/blob/master/doc/IMG_2310.PNG" width="250">
  <img src="https://github.com/DouMaokang/EventSG/blob/master/doc/IMG_2311.PNG" width="250">
  <img src="https://github.com/DouMaokang/EventSG/blob/master/doc/IMG_2299.PNG" width="250">
</p>

## Tech Details
- The fronend of EventSG is developed using Google's **Flutter framework**. We have applied the "Business Logic Component" (**Bloc**) pattern for state management within the app.
- The backend of EventSG is developed using Java's **Spring Boot** framework.
- System architecture
<p align="center">
  <img src="https://github.com/DouMaokang/EventSG/blob/master/doc/Screen%20Shot%202020-04-17%20at%204.36.26%20PM.png" width="600">
  <img src="https://github.com/DouMaokang/EventSG/blob/master/doc/Screen%20Shot%202020-04-17%20at%204.32.07%20PM.png" width="600">
</p>

## Documentations
- A complete Software Requirement Specification can be found [here](https://docs.google.com/document/d/18AbES_UrQ_l121a2KnHh4DlEHX2NLyUiwxRn3jxHhT4/edit#)
- Other design document can be found [here](https://drive.google.com/drive/u/0/folders/1RQpQ3lKQejkSNtzZeYBBFs6WtdJpb7DV)

## Future development
Our team is currently working on deploying the backend service to Google Cloud Platform and publishing the app to Google Play and App Store
