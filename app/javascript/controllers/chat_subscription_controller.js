import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="chat-subscription"
export default class extends Controller {
  static values = { chatId: Number }
  static targets = ["messages"]
  connect() {
    this.channel = createConsumer().subscriptions.create(
      { channel: "ChatChannel", id: this.chatIdValue },
      { received: data => console.log(data) }
    )
    console.log(`Subscribe to the chat with the id ${this.chatIdValue}.`)
  }
}
