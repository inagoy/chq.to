import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["passwordField", "expirationDateField"]

  connect() {
    this.toggleInput();
  }
  toggleInput() {
    const selectedValue = this.element.querySelector("select").value
    console.log(selectedValue)
    
    if (selectedValue === "ExclusiveLink") {
      this.passwordFieldTarget.classList.remove("hidden")
      this.expirationDateFieldTarget.classList.add("hidden")
    } else if (selectedValue === "TemporaryLink") {
      this.passwordFieldTarget.classList.add("hidden")
      this.expirationDateFieldTarget.classList.remove("hidden")
    } else {
      this.passwordFieldTarget.classList.add("hidden")
      this.expirationDateFieldTarget.classList.add("hidden")
    }
  }
}