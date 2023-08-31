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

  generateReport() {
    const aiMessages = Array.from(this.messagesTarget.getElementsByClassName("ai-message"));

    if (aiMessages.length > 0) {
      const reportData = aiMessages.map(message => {
        const username = "DocStashAI";
        const timestamp = message.querySelector("small i").textContent;
        const content = message.querySelector("p").textContent;
        return { username, timestamp, content };
      });

      // Convert reportData to plain text format
      const plainTextContent = reportData.map(entry => {
        return `${entry.timestamp}\n${entry.content.replace(/\n/g, " ")}\n\n`;
      }).join("");

      // Create a Blob containing the plain text data
      const blob = new Blob([plainTextContent], { type: "text/plain" });

      // Create a URL for the Blob
      const blobURL = URL.createObjectURL(blob);

      // Create a download link
      const downloadLink = document.createElement("a");
      downloadLink.href = blobURL;
      downloadLink.download = "report.txt"; // Change the filename as needed
      downloadLink.textContent = "Download Report";

      // Append the link to the DOM
      const downloadSection = document.querySelector(".download-section"); // Replace with your element's selector
      downloadSection.appendChild(downloadLink);
    }
  }




}
