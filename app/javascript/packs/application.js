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

import './bootstrap.min'
import './click-scroll'
import './custom'
import './jquery.min'
import './magnific-popup-options'
import './magnific-popup.min'
import './sticky'

Rails.start()
Turbolinks.start()
ActiveStorage.start()
