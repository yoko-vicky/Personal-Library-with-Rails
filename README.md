# Personal Library

![Screenshot](/screenshot.gif)

## About the Project

This project was built with Ruby on Rails that allows a user to login and upload an image that gets automatically tagged using an external image API service called Clarifai.

The base of this application was provided by [Lim Choon Yun (Marco)](https://github.com/marco8757) at Bower Bird as a starting point which includes Rails 6, and Bootstrap 5.

**Some keynotes**

- Implement Devise as an authentication system
- Use [Amazon S3](https://aws.amazon.com/s3/?did=ft_card&trk=ft_card) for the storage
- Use an external API, [Clarifai](https://www.clarifai.com/) for the Image tagging
- Use [Bootstrap](https://getbootstrap.com/docs/5.0/getting-started/introduction/) to create a responsive layout based on the provided [desktop wireframe](https://www.figma.com/file/IWL90EwwbVkQrK2IBUePfm/BowerTest?node-id=2%3A42) design
- Provide basic CRUD for the images and tags
- Add tests with Rspec, shoulda matchers

A list of commonly used resources that I find helpful is listed in the acknowledgments.

## Built With

- Ruby on Rails
- Ruby
- JavaScript
- JQuery
- Bootstrap
- SCSS

## Live Demo

[Live Demo Link](https://bower-test-yokosaka.herokuapp.com/)

## Getting Started

To get a local copy up and running follow these simple example steps.

1. On the project GitHub page, navigate to the main page of the repository.
2. Under the repository name, locate and click on a green button named `Code`.
3. Copy the project URL as displayed.
4. If you're running the Windows Operating System, open your command prompt. On Linux, Open your terminal.
5. Change the current working directory to the location where you want the cloned directory to be made. Leave as it is if the current location is where you want the project to be.
6. Type git clone, and then paste the URL you copied in Step 3. <br>
   e.g. $ git clone https://github.com/yourUsername/yourProjectName
7. Press Enter. Your local copy will be created.
8. To install all dependencies and necessary gems, run `bundle install`
9. Run `rails db:setup`
10. Run `rails server` to run rails application in your local server
11. Run `rspec` to run rspec tests

## Author

👤 **Yoko Saka**

- GitHub: [@yocosaka](https://github.com/yocosaka)
- Twitter: [@yocosaka](https://twitter.com/yocosaka)
- LinkedIn: [Yoko Saka](https://www.linkedin.com/in/yokosaka)

## Contributing

Contributions, issues, and feature requests are welcome!
Feel free to check the [issues page](../../issues).

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## Show your support

Give a ⭐️ if you like this project!

<!-- ## License

This project is [MIT](./LICENSE) licensed. -->

## Acknowledgements

- [carrierwave](https://github.com/carrierwaveuploader/carrierwave)
- [Amazon S3](https://aws.amazon.com/s3/?did=ft_card&trk=ft_card)
- [Clarifai](https://www.clarifai.com/)
- [Bootstrap](https://getbootstrap.com/docs/5.0/getting-started/introduction/)
