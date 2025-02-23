import { Controller } from "@hotwired/stimulus"

const DEBOUNCE_TIME = 500

export default class extends Controller {
  static targets = ["input"]
  
  connect() {
    this.timeout = null
  }
  
  debouncedSubmit() {
    clearTimeout(this.timeout)

    this.timeout = setTimeout(() => {
      this.element.requestSubmit()
    }, DEBOUNCE_TIME)
  }
} 
