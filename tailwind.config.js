/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './app/views/**/*.html.erb',  // ตรวจสอบไฟล์ .erb ทั้งหมดในโฟลเดอร์ views
    './app/helpers/**/*.rb',      // ตรวจสอบไฟล์ Ruby helpers
    './app/assets/**/*.js',       // ตรวจสอบไฟล์ JavaScript ทั้งหมดในโฟลเดอร์ assets
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}
