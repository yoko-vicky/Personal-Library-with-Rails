console.log('Hi there');

// =======================
// DRAG & DROP
// =======================
// $(function () {
//   // disable auto discover
//   Dropzone.autoDiscover = false;

//   $('.dropzone').dropzone({
//     maxFilesize: 1,
//     addRemoveLinks: true,
//   });
// });
// =======================
// SEND A REQUEST
// =======================
// const raw = JSON.stringify({
//   user_app_id: {
//     user_id: ENV['CLARIFY_USER_ID'],
//     app_id: ENV['CLARIFY_APP_ID'],
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
//     Authorization: 'Key ' + ENV['CLARIFY_ACCESS_TOKEN'],
//   },
//   body: raw,
// };

// fetch(
//   'https://api.clarifai.com/v2/models/' + ENV['CLARIFY_MODEL_ID'] + '/outputs',
//   requestOptions,
// )
//   .then((response) => response.text())
//   .then((result) =>
//     console.log(
//       JSON.parse(result, null, 2).outputs[0].data.regions.map(
//         (item) => item.data.concepts[0].name,
//       ),
//     ),
//   )
//   .catch((error) => console.log('error', error));
