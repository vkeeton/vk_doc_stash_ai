import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {
  static targets = ["container", "newChatContainer"];

  closeModal() {
    this.containerTarget.classList.add("hidden");
    this.newChatContainerTarget.classList.add("hidden");
    // this.element.nextElementSibling.classList.remove("active");
  }

  openNewChatModal() {
    this.newChatContainerTarget.classList.remove("hidden");
    this.element.nextElementSibling.classList.add("active");
}

  connect() {
  }
}
