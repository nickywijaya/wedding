// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import JQuery from 'jquery';
import JQueryUJS from 'jquery-ujs';
window.$ = window.JQuery = JQuery;

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"


JQueryUJS.start()

import './main.js';
import './google_map.js';
import './jquery.countTo.js';
import './jquery.easing.1.3.js';
import './jquery.min.js';



import './simplyCountdown.js';
import './bootstrap.min.js';
import './jquery.magnific-popup.min.js';
import './jquery.waypoints.min.js';
import './jquery.stellar.min.js';
import './modernizr-2.6.2.min.js';
import './owl.carousel.min.js';
import './respond.min.js';
import './magnific-popup-options.js';


Rails.start()
Turbolinks.start()
ActiveStorage.start()
