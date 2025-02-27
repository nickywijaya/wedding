// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import $ from 'jquery';
global.$ = jQuery; // This will make jQuery available globally

import AOS from 'aos'; // Import AOS library
import 'aos/dist/aos.css'; // Import AOS styles

AOS.init(); // Initialize AOS

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

// require('aos')
// require('bootstrap.bundle.min')
// require('ekko-lightbox.min')
// require('jquery.min')
// require('jquery.slim.min')
// require('main')

import 'css/site.scss'
import './jquery.min'
import './bootstrap.bundle.min'
import './ekko-lightbox.min'
import './aos'
import './main'
