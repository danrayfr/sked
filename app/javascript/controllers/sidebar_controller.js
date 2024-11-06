import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "main", "menu", "overlay", "dropdownToggle" ];

  connect() {
    console.log("Sidebar Stimulus Controller...")
    this.checkWindowSize();
    window.addEventListener("resize", this.checkWindowSize.bind(this));
  }

  checkWindowSize() {
    if (window.innerWidth < 768) {
      this.menuTarget.classList.add("-translate-x-full"); // Start with sidebar hidden on mobile
      this.overlayTarget.classList.add("hidden"); // Hide overlay on mobile
    } else {
      this.menuTarget.classList.remove("-translate-x-full"); // Show sidebar on larger screens
      this.overlayTarget.classList.add("hidden"); // Hide overlay on larger screens
    }
  }

  toggle() {
    this.mainTarget.classList.toggle("active")
    this.overlayTarget.classList.toggle("hidden")
    this.menuTarget.classList.toggle("-translate-x-full")
  }

  closeSidebar() {
    this.mainTarget.classList.add("active")
    this.menuTarget.classList.add("-translate-x-full")
    this.overlayTarget.classList.add("hidden")
  }
}