// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import JQuery from 'jquery';
window.$ = window.JQuery = JQuery;

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import SmoothScroll from 'smooth-scroll';  // Import the smooth-scroll library

Rails.start()
Turbolinks.start()
ActiveStorage.start()

// scrolling effect
document.addEventListener("DOMContentLoaded", function() {
  // Initialize SmoothScroll for links with href that contain #
  var scroll = new SmoothScroll('a[href*="#"]');
});
