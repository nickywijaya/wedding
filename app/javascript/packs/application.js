// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import $ from 'jquery';
global.$ = global.jQuery = $;

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import './google_map.js';
import './jquery.countTo.js';
import './jquery.easing.1.3.js';
import './jquery.magnific-popup.min.js';
import './jquery.min.js';
import './jquery.stellar.min.js';
import './jquery.waypoints.min.js';
import './magnific-popup-options.js';
import './main.js';
import './modernizr-2.6.2.min.js';
import './owl.carousel.min.js';
import './respond.min.js';
import './simplyCountdown.js';
import './bootstrap.min.js';

Rails.start()
Turbolinks.start()
ActiveStorage.start()
