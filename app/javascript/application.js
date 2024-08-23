// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "popper"
import "bootstrap"

document.addEventListener('turbo:load', () => {
  // Handle message modal
  const messageModal = document.getElementById('messageModal');
  if (messageModal) {
    messageModal.addEventListener('show.bs.modal', (event) => {
      const button = event.relatedTarget;
      const name = button.getAttribute('data-name');
      const email = button.getAttribute('data-email');
      const message = button.getAttribute('data-message');
      
      const modalTitle = messageModal.querySelector('.modal-title');
      const modalBody = messageModal.querySelector('.modal-body');
      
      modalTitle.textContent = `Message from ${name} (${email})`;
      modalBody.textContent = message;
    });
  }
});
