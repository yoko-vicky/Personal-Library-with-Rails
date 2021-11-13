// require('dotenv').config();

console.log('Hi there');
// console.log(process.env.CLARIFY_APP_ID);

// function paintIt() {}

// =======================
// SEND A REQUEST
// =======================
// const raw = JSON.stringify({
//   user_app_id: {
//     user_id: process.env.CLARIFY_USER_ID,
//     app_id: process.env.CLARIFY_APP_ID,
//   },
//   inputs: [
//     {
//       data: {
//         image: {
//           url: 'https://samples.clarifai.com/metro-north.jpg',
//         },
//       },
//     },
//   ],
// });

// const requestOptions = {
//   method: 'POST',
//   headers: {
//     Accept: 'application/json',
//     Authorization: 'Key ' + process.env.CLARIFY_ACCESS_TOKEN,
//   },
//   body: raw,
// };

// fetch(
//   'https://api.clarifai.com/v2/models/9f54c0342741574068ec696ddbebd699/outputs',
//   requestOptions,
// )
//   .then((response) => response.text())
//   .then((result) =>
//     console.log(
//       JSON.parse(result, null, 2).outputs[0].data.regions.map(
//         (item) => item.data.concepts[0].name,
//       ),

//       // JSON.parse(result),
//     ),
//   )
//   .catch((error) => console.log('error', error));
