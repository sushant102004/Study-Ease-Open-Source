## Study-Ease 🔥

Study Ease is designed to help students by providing free study notes. It consists of free educational material for engineering students. You can easily search topic-wise notes, or you can also upload your own notes if you want. You can also browse and join several technical events that are going on and join them.

🚀 Deployed URL: [Play Store](https://play.google.com/store/apps/details?id=com.sushant.studyease)

<b>Important:</b> This documentation is still under developement.

<br>

### Technologies Used
#### App
![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white) ![Firebase](https://img.shields.io/badge/Firebase-039BE5?style=for-the-badge&logo=Firebase&logoColor=white)

#### Backend Server

![JavaScript](https://img.shields.io/badge/javascript-%23323330.svg?style=for-the-badge&logo=javascript&logoColor=%23F7DF1E) ![NodeJS](https://img.shields.io/badge/node.js-6DA55F?style=for-the-badge&logo=node.js&logoColor=white) ![Express.js](https://img.shields.io/badge/express.js-%23404d59.svg?style=for-the-badge&logo=express&logoColor=%2361DAFB) ![MongoDB](https://img.shields.io/badge/MongoDB-%234ea94b.svg?style=for-the-badge&logo=mongodb&logoColor=white) ![DigitalOcean](https://img.shields.io/badge/DigitalOcean-%230167ff.svg?style=for-the-badge&logo=digitalOcean&logoColor=white)

<br>

### Local Setup

Study Ease requires [Flutter](https://flutter.dev/) and [Node.js](https://nodejs.org/) to run.

```
git clone https://github.com/sushant102004/Study-Ease-Open-Source.git
```

#### Project Structure
 - After running above command Study Ease you will get 2 folders. 
 - <b>study_ease</b> contain Flutter app and <b>backend_server</b> contain NodeJS server code.

<br>

#### Backend Server .env setup

```
PORT = 3000
MONGODB_URI = <MongoDB_URI>

JWT_SECRET = <JWT_Secret>
SpacesEndpoint = <DigitalOceanSpacesEndpoint>
SpacesAccessKey = <DigitalOceanSpacesAccessKey>
SpacesSecretAccessKey = <DigitalOceanSpacesAccessKeySecret>

MAILGUN_USER = <MailgunUser>
MAILGUN_PASSWORD = <MailgunPassword>
```

#### App Setup

Change <b>APIBaseURL</b> with localhost:3000/api/v1/apiRoute

<br></br>
### Licence

You can only contribute to Study Ease via pull request. You are not allowed to compile an apk file and upload or sell it anywhere. You are free to contribute and mention this project in your resume if your pull request get merged.
