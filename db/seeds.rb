# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# db/seeds.rb
page_content =PageContent.create!(
  home_header: "Welcome to Our IT Company",
  mission: "To deliver cutting-edge technology solutions that drive innovation and success.To be the leading provider of IT services, recognized for our excellence and client-focused approach.To be the leading provider of IT services, recognized for our excellence and client-focused approach.To be the leading provider of IT services, recognized for our excellence and client-focused approach.To be the leading provider of IT services, recognized for our excellence and client-focused approach.To be the leading provider of IT services, recognized for our excellence and client-focused approach.To be the leading provider of IT services, recognized for our excellence and client-focused approach.To be the leading provider of IT services, recognized for our excellence and client-focused approach.To be the leading provider of IT services, recognized for our excellence and client-focused approach.",
  vision: "To be the leading provider of IT services, recognized for our excellence and client-focused approach.To be the leading provider of IT services, recognized for our excellence and client-focused approach.To be the leading provider of IT services, recognized for our excellence and client-focused approach.To be the leading provider of IT services, recognized for our excellence and client-focused approach.To be the leading provider of IT services, recognized for our excellence and client-focused approach.To be the leading provider of IT services, recognized for our excellence and client-focused approach.To be the leading provider of IT services, recognized for our excellence and client-focused approach.To be the leading provider of IT services, recognized for our excellence and client-focused approach.",
  about_header: "About Us",
  about_us: "We are a forward-thinking IT company with a passion for technology and innovation. Our team is dedicated to providing top-notch IT services and solutions to help businesses succeed in the digital age.We are a forward-thinking IT company with a passion for technology and innovation.
Our team is dedicated to providing top-notch IT services and solutions to help businesses succeed in the digital age.We are a forward-thinking IT company with a passion for technology and innovation. Our team is dedicated to providing top-notch IT services and solutions to help businesses succeed in the digital age.We are a forward-thinking IT company with a passion for technology and innovation. Our team is dedicated to providing top-notch IT services and solutions to help businesses succeed in the digital age.We are a forward-thinking IT company with a passion for technology and innovation. Our team is dedicated to providing top-notch IT services and solutions to help businesses succeed in the digital age.We are a forward-thinking IT company with a passion for technology and innovation.
Our team is dedicated to providing top-notch IT services and solutions to help businesses succeed in the digital age.We are a forward-thinking IT company with a passion for technology and innovation. Our team is dedicated to providing top-notch IT services and solutions to help businesses succeed in the digital age.We are a forward-thinking IT company with a passion for technology and innovation.
Our team is dedicated to providing top-notch IT services and solutions to help businesses succeed in the digital age.We are a forward-thinking IT company with a passion for technology and innovation. Our team is dedicated to providing top-notch IT services and solutions to help businesses succeed in the digital age.We are a forward-thinking IT company with a passion for technology and innovation.
Our team is dedicated to providing top-notch IT services and solutions to help businesses succeed in the digital age.We are a forward-thinking IT company with a passion for technology and innovation. Our team is dedicated to providing top-notch IT services and solutions to help businesses succeed in the digital age.
We are a forward-thinking IT company with a passion for technology and innovation. Our team is dedicated to providing top-notch IT services and solutions to help businesses succeed in the digital age.",
  history: "Founded in 2010, we have grown from a small startup to a leading IT services provider. Our journey is marked by numerous milestones and achievements that reflect our commitment to excellence.Founded in 2010, we have grown from a small startup to a leading IT services provider. Our journey is marked by numerous milestones and achievements that reflect our commitment to excellence.Founded in 2010, we have grown from a small startup to a leading IT services provider. Our journey is marked by numerous milestones and achievements that reflect our commitment to excellence.Founded in 2010, we have grown from a small startup to a leading IT services provider. Our journey is marked by numerous milestones and achievements that reflect our commitment to excellence.Founded in 2010, we have grown from a small startup to a leading IT services provider. Our journey is marked by numerous milestones and achievements that reflect our commitment to excellence.Founded in 2010, we have grown from a small startup to a leading IT services provider. Our journey is marked by numerous milestones and achievements that reflect our commitment to excellence.Founded in 2010, we have grown from a small startup to a leading IT services provider. Our journey is marked by numerous milestones and achievements that reflect our commitment to excellence.Founded in 2010, we have grown from a small startup to a leading IT services provider. Our journey is marked by numerous milestones and achievements that reflect our commitment to excellence.Founded in 2010, we have grown from a small startup to a leading IT services provider. Our journey is marked by numerous milestones and achievements that reflect our commitment to excellence.Founded in 2010, we have grown from a small startup to a leading IT services provider. Our journey is marked by numerous milestones and achievements that reflect our commitment to excellence.Founded in 2010, we have grown from a small startup to a leading IT services provider. Our journey is marked by numerous milestones and achievements that reflect our commitment to excellence.Founded in 2010, we have grown from a small startup to a leading IT services provider. Our journey is marked by numerous milestones and achievements that reflect our commitment to excellence.",
  ceo: "Jane Doe",
  contact_header: "Contact Us,We are here to help!"
)
page_content.home_img.attach(
  io: File.open(Rails.root.join('app/assets/images/home.jpg')),
  filename: 'home.jpg',
  content_type: 'image/jpeg'
)

page_content.ceo_img.attach(
  io: File.open(Rails.root.join('app/assets/images/ceo.jpg')),
  filename: 'ceo.jpg',
  content_type: 'image/jpeg'
)

User.create!(
  email: "adminuser@yopmail.com",
  password: "123456",
  name: "biya",
  role: "admin",
  status: true
)
Contact.create!(
  phone:"+1234567890",
  email:"info@xyzitsolutions.com",
  address:"123 xyz Street,london",
  website:"http://www.xyzitsolution.com"

)
