import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="administrator"
export default class extends Controller {
  submitOnChange(event) {
    const formElement = this.element;

    // Optional: Confirm before submitting
    const confirmMessage = "Are you sure you want to change this person's administrative role in your organization?";
    if (confirm(confirmMessage)) {
      formElement.requestSubmit();
    } else {
      event.preventDefault(); // Prevent form submission if not confirmed
    }
  }
}
