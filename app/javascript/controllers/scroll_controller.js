import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    this.scrollToBottom();
    this.observeMessages();
  }

  scrollToBottom() {
    [...this.element.children].at(-1).scrollIntoView({ behavior: "smooth" });
  }

  observeMessages() { //
    console.log("Observing new messages...");
    const observer = new MutationObserver(() => {
      console.log("New message detected");
      if (this.isAtBottom()) {
        console.log("User was at bottom, scrolling...");
        this.scrollToBottom();
      } else {
        console.log("User was not at bottom, not scrolling");
      }
    });

    observer.observe(this.element, { childList: true, subtree: true });
  }

  isAtBottom() { // Does not work as expected
    const distanceFromBottom =
      this.element.scrollHeight - this.element.scrollTop - this.element.clientHeight;
    console.log("Distance from bottom:", distanceFromBottom);
    return distanceFromBottom < 50;
  }
}
