# Pin npm packages by running ./bin/importmap

pin "application", to: "application.js"
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascripts", under: "javascripts"
pin "item_price", to: "item_price.js"
pin "card", to: "card.js"