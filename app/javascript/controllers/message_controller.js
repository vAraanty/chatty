import { Controller } from "@hotwired/stimulus"

const OPACITY_TRANSITION_DELAY = 50;
const OPACITY_TRANSITION_CLASS = "opacity-0";

// Connects to data-controller="message"
export default class extends Controller {
  connect() {
    setTimeout(() => {
      this.element.classList.remove(OPACITY_TRANSITION_CLASS);
    }, OPACITY_TRANSITION_DELAY);
  }
}
