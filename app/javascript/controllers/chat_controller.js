import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.scrollToBottom()
  }

  sendOnEnter(e) {
    if (e.key === "Enter" && !e.shiftKey) {
      e.preventDefault()
      e.target.form.requestSubmit()
      e.target.value = ""
    }
  }

  scrollToBottom() {
    this.element.scrollTop = this.element.scrollHeight
  }
}
