import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "cancel" ]

  confirmSubmission(event) {
    const message = "Are you sure you want to make this person an administrator? Please check again.";

    // Display a confirmation dialog
    if (confirm(message)) {
      this.submit(); // If confirmed, submit the form
    } else {
      event.preventDefault(); // Otherwise, prevent the checkbox change
    }
  }

  submit() {
    this.element.requestSubmit()
  }

  cancel() {
    this.cancelTarget?.click()
  }

  preventAttachment(event) {
    event.preventDefault()
  }
}
