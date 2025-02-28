// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import JQuery from 'jquery';
window.$ = window.JQuery = JQuery;

import 'owl.carousel';

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

import 'css/site.scss'
import './jquery.min'
import './bootstrap.min'
import './easing.min'
import './isotope'
import './lightbox.min'
import './main'
import './owl.carousel.min'
import './waypoints.min'