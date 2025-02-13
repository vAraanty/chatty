import { Controller } from "@hotwired/stimulus"

const FLASH_DURATION = 10_000
const FLASH_TRANSITION_DURATION = 500

export default class extends Controller {
  static targets = ["message"]

  connect() {
    this.messageTargets.forEach(message => {
      requestAnimationFrame(() => {
        message.classList.remove("translate-y-[-150%]")
      })

      setTimeout(() => {
        message.classList.add("translate-y-[-150%]")
        setTimeout(() => {
          message.remove()
        }, FLASH_TRANSITION_DURATION)
      }, FLASH_DURATION)
    })
  }
} 
