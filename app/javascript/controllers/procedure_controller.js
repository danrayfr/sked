import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["select", "fee"]

  connect() {
    console.log("ProcedureController connected")
  }

  updateFee() {
    const selectedOption = this.selectTarget.selectedOptions[0]

    const cost = selectedOption.dataset.cost

    this.feeTarget.value = cost || ''
  }
}