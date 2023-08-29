import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {
  static targets = ["container"];

  closeModal() {
    this.containerTarget.classList.add("hidden");
    this.element.nextElementSibling.classList.remove("active");
  }
  connect() {
  }
}
