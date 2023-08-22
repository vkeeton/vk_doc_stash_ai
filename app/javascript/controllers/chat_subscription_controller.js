import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="chat-subscription"
export default class extends Controller {
  static values = { chatId: Number }
  static targets = ["messages"]
  connect() {
    this.channel = createConsumer().subscriptions.create(
      { channel: "ChatChannel", id: this.chatIdValue },
      { received: data => {
        this.messagesTarget.insertAdjacentHTML("beforeend", data)
        setTimeout(() => {
          this.messagesTarget.scroll(0, this.messagesTarget.scrollHeight)
        }, 1000);
        // this.chatTarget.scroll(0, this.chatTarget.scrollHeight);
        console.log("Code has run")
      }
      }
    )
    console.log(`Subscribe to the chat with the id ${this.chatIdValue}.`)
  }

  disconnect() {
    console.log("Unsubscribed from the chat")
    this.channel.unsubscribe()
  }

  resetForm(event) {
    const form = event.target
    form.reset()
  }
}
