import { Controller } from "@hotwired/stimulus"

const MENU_WIDTH_CLASS = `w-75`
const MENU_WIDTH_CONTENT_CLASS = `ml-75`

// Connects to data-controller="menu"
export default class extends Controller {
  static targets = ["menu", "content"]

  open() {
    this.menuTarget.classList.add(MENU_WIDTH_CLASS)
    this.contentTarget.classList.add(MENU_WIDTH_CONTENT_CLASS)
  }

  close() {
    this.menuTarget.classList.remove(MENU_WIDTH_CLASS)
    this.contentTarget.classList.remove(MENU_WIDTH_CONTENT_CLASS)
  }
}
