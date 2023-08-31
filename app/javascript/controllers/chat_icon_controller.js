import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="chat-icon"
export default class extends Controller {
  static targets = ["show"]

  showText() {
    // this.showTarget.classList.add("hover-show")
    this.showTarget.classList.remove("d-none")


  };

  hideText() {
    // this.showTarget.classList.remove("hover-show")
    this.showTarget.classList.add("d-none")
  };
}
