import { Controller } from "@hotwired/stimulus"

const TEXT_AREA_BORDER_SIZE = 1.65

// Connects to data-controller="chat-input"
export default class extends Controller {
  resize() {
    this.element.style.height = "auto";
    this.element.style.height = (this.element.scrollHeight + TEXT_AREA_BORDER_SIZE * 2) + "px";
  }
}
