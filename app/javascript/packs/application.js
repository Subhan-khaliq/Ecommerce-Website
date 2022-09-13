


const images = require.context('../images', true)
const imagePath = (name) => images(name, true)

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"

import "channels"
import "jquery"
import "bootstrap"

Rails.start()
Turbolinks.start()
ActiveStorage.start()
import 'src/stylesheets/application'
