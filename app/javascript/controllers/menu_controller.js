import { Controller } from "@hotwired/stimulus"

const MENU_OPEN_WIDTH_CLASS = `w-75`
const MENU_CLOSED_WIDTH_CLASS = `w-0`

const MENU_OPEN_CONTENT_CLASS = `ml-75`
const MENU_CLOSED_CONTENT_CLASS = `ml-0`

// Connects to data-controller="menu"
export default class extends Controller {
  static targets = ["menu", "content"]

  open() {
    this.toggleMenu(true)
  }

  close() {
    this.toggleMenu(false)
  }

  toggleMenu(state) {
    this.menuState = state
    this.menuTarget.classList.toggle(MENU_OPEN_WIDTH_CLASS, state)
    this.menuTarget.classList.toggle(MENU_CLOSED_WIDTH_CLASS, !state)
    this.contentTarget.classList.toggle(MENU_OPEN_CONTENT_CLASS, state)
    this.contentTarget.classList.toggle(MENU_CLOSED_CONTENT_CLASS, !state)
  }

  set menuState(state) {
    document.cookie = `menu_is_open=${state}; path=/; max-age=31536000`;
  }

  get menuState() {
    return document.cookie.includes("menu_is_open=true");
  }
}
