import { Controller } from "@hotwired/stimulus"

const TEXT_AREA_BORDER_SIZE = 1.65

// Connects to data-controller="chat-input"
export default class extends Controller {
  static targets = ["input", "form"]

  resize() {
    this.inputTarget.style.height = "auto";
    this.inputTarget.style.height = (this.inputTarget.scrollHeight + TEXT_AREA_BORDER_SIZE * 2) + "px";
  }

  submitForm(event) {
    event.preventDefault()

    if (this.inputTarget.value.trim() === "") {
      return
    }

    this.formTarget.requestSubmit()
  }
}
