import nodemailer from "nodemailer";

const transporter = nodemailer.createTransport({
  host: "smtp.gmail.com",
  port: 465,
  secure: true,
  auth: {
    user: process.env.ADMIN_MAIL,
    pass: process.env.ADMIN_PASS,
  },
});

export default transporter;
