// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

// import $ from './jquery.min';
// window.jQuery = $;
// window.$ = $;

import JQuery from 'jquery';
window.$ = window.JQuery = JQuery;

import Popper from 'popper.js';
import 'bootstrap/dist/js/bootstrap.min.js';

// import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

// Rails.start()
Turbolinks.start()
ActiveStorage.start()


import './jquery.min'
import 'css/site.scss'
import './bootstrap.min'
//import './google_map'
import './jquery.countTo'
import './jquery.easing.1.3'
import './jquery.magnific-popup.min'
import './jquery.stellar'
import './jquery.waypoints.min'
import './magnific-popup-options'
import './owl.carousel.min'
import './jquery.magnific-popup.min'
import './simplyCountdown'
import './main'
